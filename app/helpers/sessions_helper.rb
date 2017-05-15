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

  # set the current user to the currently-logged in user
  def current_user
    @current_user ||= User.find_by(id: session[:user_id])
  end

  # results in a boolean value based on presence of user id in session[:user_id]
  def logged_in?
    !current_user.nil?
  end

  # Logs out the current user.
  def logout
    session.delete(:user_id)
    @current_user = nil
  end
end
