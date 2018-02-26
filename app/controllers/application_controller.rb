class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception



  def hello_gdg

    return render html: "<strong>Welcome To GDG</strong>".html_safe
  end

end
