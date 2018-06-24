module ErrorNotification
  extend ActiveSupport::Concern


#   put the error code and the file to be displayed over here



  class ResponseTypes
    JS = :js
    HTML = :html
    JSON = :json

  end

  class ErrorCodes
    UNAUTHORIZED = 403
    NOT_FOUND = 404
    INVALID_INPUT = 422

  end



end