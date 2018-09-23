module UrlHelper

  def complete_url url_string
    unless url_string[/\Ahttp:\/\//] || url_string[/\Ahttps:\/\//]
      url_string = "http://#{url_string}"
    end
    return url_string
  end


  def twitter_url handle
    if handle[0] == '@'
      url_string = "http://twitter.com/#{handle}"
    end
    return url_string
  end


end