class SessionsController < ApplicationController

  # GET /signin
  def new
    # fail
  end

  # POST /signin
  def create
    user = User.find_by(email: params[:session][:email].downcase)
    if authenticated_successfully(user)
      login(user)
      params[:session][:remember_me] == '1' ? remember(user) : forget(user)
      remember(user)
      flash[:success] = "You've signed in successfully, #{user.first_name}!"
      redirect_to user_url(user)
    else
      flash.now[:danger] = "Hmm... that doesn't seem to be the correct email and password combination."
      render 'new'
    end
  end

  # DELETE /signout
  def destroy
    # fail
    logout if logged_in?
    flash[:success] = "You've successfully logged out!"
    redirect_to root_url
  end
end
