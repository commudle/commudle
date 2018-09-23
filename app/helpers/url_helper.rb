module UrlHelper

  def complete_url url_string
    unless url_string[/\Ahttp:\/\//] || url_string[/\Ahttps:\/\//]
      url_string = "http://#{self.url}"
    end
    return url_string
  end


end