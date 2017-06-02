class StaticPagesController < ApplicationController
  # return the corresponding view to 'home' action
  def home
    # fail
    if logged_in?
      @micropost  = current_user.microposts.build
      @feed_items = current_user.feed.paginate(page: params[:page])
    end
  end

  # return the corresponding view to 'help' action
  def help
    # fail
  end

  # return the corresponding view to 'about' action
  def about
    # fail
  end

  # return the corresponding view to 'contact' action
  def contact
    # fail
  end
end
