class AppsController < ApplicationController
  def index
    @apps = current_user.apps
  end

  def new
    @app = App.new
  end

  def create
    @app = current_user.apps.new(params[:app].permit(:name, :redirect_uri))
    @app.app_key = Devise.friendly_token[0...15]
    @app.app_secret = Devise.friendly_token[0...15]

    if @app.save
      redirect_to edit_app_path(@app)
    else
      render "new"
    end
  end

  def edit
    @app = App.find(params[:id])
  end

  def update
    @app = App.find(params[:id])
    if @app.update_attributes(params[:app].permit(:redirect_uri, :name, :publisher, :description, :website))
      redirect_to edit_app_path(@app)
    else
      render "edit"
    end
  end

  def destroy
    @app.destroy
    redirect_to apps_path
  end

  def shorten_url
    if params[:client_id].nil? || params[:client_id].empty?
      render :json => {:error => "The given value doesn't exist or has expired."}
    else
      app = App.where(:app_key => params[:client_id]).first

      if app.nil?
        render :json => {:error => "The given value doesn't exist or has expired."}
      else
        redirect_to authorize_path(:client_id => app.app_key, :response_type => "token", :redirect_uri => app.redirect_uri)
      end
    end
  end
end
