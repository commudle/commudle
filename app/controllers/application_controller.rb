class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception



  def hello_gdg

    return render html: "<strong>Welcome To GDG</strong>".html_safe
  end


  def throw_error(error_notification_code)
    return render html: error_notification_code
  end

end
