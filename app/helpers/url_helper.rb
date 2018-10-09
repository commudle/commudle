module UrlHelper

  # if a url in text doesn't have http or https, add http to it
  def complete_url url_string
    unless url_string[/\Ahttp:\/\//] || url_string[/\Ahttps:\/\//]
      url_string = "http://#{url_string}"
    end
    return url_string
  end

  # convert a handle (@) to twitter url
  def twitter_url handle
    if handle[0] == '@'
      url_string = "http://twitter.com/#{handle}"
    end
    return url_string
  end

  # wrap urls in a text with <a> tag
  def wrap_url_anchor text_string

    regexp = /(https?:\/\/)?\w*\.\w+(\.\w+)*(\/\w+)*(\.\w*)?/


    return text_string.gsub(regexp){|url| "<a target='_blank' href=#{complete_url(url)}>#{url}</a>"}.html_safe

  end


end