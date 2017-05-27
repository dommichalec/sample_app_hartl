module SessionsHelper

  # identify authenticity, use the bang-bang to coerce the result to a
  # boolean value of either true or false
  def authenticated_successfully(user)
    !!(user && user.authenticate(params[:session][:password]))
  end

  # log in a user and give persistence to session with a user id
  def login(user)
    session[:user_id] = user.id
  end

  # Logs out the current user.
  def logout
    forget(current_user)
    session.delete(:user_id)
    @current_user = nil
  end

  # set the current user to the currently-logged in user
  # Returns the user corresponding to the remember token cookie.
  def current_user
    if (user_id = session[:user_id])
      @current_user ||= User.find_by(id: user_id)
    elsif (user_id = cookies.signed[:user_id])
      user = User.find_by(id: user_id)
      if user && user.authenticated?(cookies[:remember_token])
        log_in user
        @current_user = user
      end
    end
  end

  def current_user?(user)
    user == current_user
  end

  # results in a boolean value based on presence of user id in session[:user_id]
  def logged_in?
    !current_user.nil?
  end

  # Remembers a user in a persistent session.
  def remember(user)
    user.remember
    cookies.permanent.signed[:user_id] = user.id
    cookies.permanent[:remember_token] = user.remember_token
  end

  # Forgets a persistent session.
  def forget(user)
    user.forget
    cookies.delete(:user_id)
    cookies.delete(:remember_token)
  end

  # Redirects to stored location (or to the default).
  def redirect_back_or(default)
    redirect_to(session[:forwarding_url] || default)
    session.delete(:forwarding_url)
  end

  # Stores the URL trying to be accessed.
  def store_location
    session[:forwarding_url] = request.original_url if request.get?
  end
end
