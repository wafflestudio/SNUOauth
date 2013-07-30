class MainController < ApplicationController
  def home
  end

  def api
    redirect_to "http://wafflestudio.github.io/SNUOauth/"
  end

  def about
    redirect_to "http://wafflestudio.github.io/SNUOauth/"
  end

  def contact
    redirect_to "mailto:tantara@wafflestudio.com"
  end

  def facebook
    redirect_to "https://www.facebook.com/taekmin.kim"
  end
end
