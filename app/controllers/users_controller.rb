class UsersController < ApplicationController

  # GET /users/new
  def new
    # fail
    @user = User.new
  end

  # POST /users/new
  def create
    @user = User.new(user_params)
    if @user.save
      flash[:success] = "Welcome to the site, #{@user.first_name}!"
      redirect_to user_url(@user)
    else
      render 'new'
    end
  end

  # GET /users/:id
  def show
    # fail
    @user = User.find(params[:id])
  end

  private

  def user_params
    params.require(:user).permit(:first_name, :last_name, :email, :password,
                                 :password_confirmation)
  end
end
