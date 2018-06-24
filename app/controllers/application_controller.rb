class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception



  def hello_gdg

    return render html: "<strong>Welcome To GDG</strong>".html_safe
  end


  def error_response(response_type, error_code, message, data={})
    @message = message
    return render response_type, file: 'application/error_response', status: error_code
  end

end
