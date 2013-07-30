class AppsController < ApplicationController
  def index
    @apps = App.all
  end

  def new
    @app = App.new
  end

  def create
    #@app = current_user.apps.new(params[:app])
    @app = App.new(params[:app].permit(:name, :redirect_uri))
    @app.app_key = Devise.friendly_token[0,10]
    @app.app_secret = Devise.friendly_token[0,20]

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
end
