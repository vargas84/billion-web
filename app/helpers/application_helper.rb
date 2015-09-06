module ApplicationHelper
  def embed(youtube_url)
    youtube_id = youtube_url.split('=').last
    iframe = content_tag(:iframe, nil, src: "//www.youtube.com/embed/#{youtube_id}")
    content_tag(:div, iframe, class: 'embed-container')
  end
end
