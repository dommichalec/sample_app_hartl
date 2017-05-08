module ApplicationHelper
  # set the title of the entire application to constant SITE_TITLE
  $SITE_TITLE = "Ruby on Rails Tutorial Sample App"

  # return the page title in the browser tab on a per-page basis
  def full_title(page_title = '')
    page_title.blank? ? $SITE_TITLE : page_title + " | " + $SITE_TITLE
  end
end
