module ApplicationHelper

  # return the page title in the browser tab on a per-page basis
  def full_title(page_title = '')
    base_title = "Ruby on Rails Tutorial Sample App"
    page_title.blank? ? base_title : page_title + " | " + base_title
  end
end
