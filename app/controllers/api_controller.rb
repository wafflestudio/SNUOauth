#encoding: utf-8
require 'net/http'
require 'nokogiri'

class ApiController < ApplicationController
  before_filter :get_siticket, :only => [:authorize]
  before_filter :set_cookie, :only => [:authorize]
  before_filter :get_cookie, :except => [:authorize]
  before_filter :configure_http

  def test
  end

  def authorize
    if params[:client_id].nil? || params[:client_id].empty?
      render :json => {:error => "client_id is required."}
    elsif params[:response_type].nil? || params[:response_type].empty?
      render :json => {:error => "response_type is required."}
    elsif params[:response_type].to_s != "token"
      render :json => {:error => "response_type will always be 'bearer'."}
    elsif params[:redirect_uri].nil? || params[:redirect_uri].empty?
      render :json => {:error => "redirect_uri is required."}
    else
      app = App.where(:app_key => params[:client_id]).first

      if app.nil?
        render :json => {:error => "The given client_id doesn't exist."}
      elsif params[:redirect_uri].to_s != app.redirect_uri 
        render :json => {:error => "It must exactly match one of the redirect URIs you've pre-configured for your app"}
      else
        #email
        path = "/app/acct_info.do" # 학적

        resp, body = @http.get(path, @cookie)
        doc = Nokogiri::XML(resp.body)

        email = doc.xpath("//email").text

        user = User.find_for_mysnu_oauth(email, @siticket)
        #email end

        if user.nil?
          render :json => {:error => "MySNU Login failed."}
        else
          app_token = user.app_tokens.where(:app_id => params[:client_id]).first
          if app_token.nil?
            app_token = user.app_tokens.new
            app_token.app = app
            app_token.access_token = Devise.friendly_token[0,64]
            app_token.expired_at = Time.now + 1.days

            if app.save
              render :html
            else
              render :json => {:error => "MySNU Login failed."}
            end
          elsif app_token.authorized
            redirect_to "#{params[:redirect_uri]}?access_token=#{app_token.access_token}&token_type=#{app_token.token_type}&uid=#{app_token.user.id}"
          else
            render :html
          end
        end
      end
    end
  end

  def account_info #/account/info
    begin
      path = "/app/acct_info.do"

      resp, body = @http.get(path, @cookie)
      doc = Nokogiri::XML(resp.body)

      email = doc.xpath("//email").text
    rescue
      #TODO
    end

    render :json => ""
  end

  private
  def get_siticket
    cookie = env["HTTP_COOKIE"].to_s
    regexp_siticket = /SITicket=(.*);|SITicket=(.*)$/
    cookie.match(regexp_siticket).to_s
    @siticket = $1.nil? ? $2 : $1

    redirect_url = "http://sso.snu.ac.kr/snu/ssologin.jsp?si_redirect_address=#{request.original_url}"
    logger.info "###Redirect URL: " + redirect_url.to_s
    redirect_to redirect_url if @siticket.nil? || @siticket.empty?
  end
  def set_cookie
    @cookie = {"Cookie" => "SITicket=#{@siticket}"}
  end
  def get_cookie
    if params[:access_token].nil? || params[:access_token].empty?
      render :json => {:error => "The given OAuth 2 access token doesn't exist or has expired."}
      return
    else
      @app_token = AppToken.where(:access_token => params[:access_token]).first

      if @app_token.nil? || @app_token.expired_at > Time.now
        render :json => {:error => "The given OAuth 2 access token doesn't exist or has expired."}
        return
      else
        @siticket = @app_token.user.token
        @cookie = {"Cookie" => "SITicket=#{@siticket}"}
      end
    end
  end
  def configure_http
    servers = [
      {:host => "app.snu.ac.kr", :port => 80}#,
      #{:host => "diana.snu.ac.kr", :port => 38080},
      #{:host => "noel.snu.ac.kr", :port => 38080}
    ]

    server = servers[rand(servers.length)]
    @http = Net::HTTP.new(server[:host], server[:port])
  end
end
