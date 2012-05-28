module ApplicationHelper

  def redcloth(content)
    RedCloth.new(content).to_html.html_safe
  end

end
