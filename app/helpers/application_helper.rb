module ApplicationHelper

  def redcloth(content)
    RedCloth.new(content).to_html.html_safe
  end

  def owner_or_admin?
    logged_in? && (current_user == @tournament.user || current_user.admin?)
  end
end
