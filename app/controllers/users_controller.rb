class UsersController < ApplicationController
  before_action :require_logged_in_user,    only: [:index, :edit, :update, :destroy]
  before_action :require_correct_user,      only: [:edit, :update]
  before_action :require_admin_user,        only: :destroy

  # responds to GET /users
  def index
    @users = User.paginate(page: params[:page], per_page: 15)
  end

  # responds to GET /users/new
  def new
    # fail
    @user = User.new
  end

  # responds to GET /users/:id/edit
  def edit
    # fail
    @user = User.find(params[:id])
  end

  # responds to POST /users/:id/edit
  def update
    # fail
    @user = User.find(params[:id])
    if @user.update_attributes(user_params)
      flash[:success] = "Profile updated successfully!"
      redirect_to user_url(@user)
    else
      flash[:danger] = "Ah snap! There were some issues with your updates."
      render 'edit'
    end
  end

  # responds to POST /users/new
  def create
    # fail
    @user = User.new(user_params)
    if @user.save
      login(@user)
      flash[:success] = "Welcome to the site, #{@user.first_name}!"
      redirect_to user_url(@user)
    else
      render 'new'
    end
  end

  # responds to DELETE /users/:id
  def destroy
    #fail
    User.find(params[:id]).destroy
    flash[:success] = "User deleted"
    redirect_to users_url
  end

  # responds to 3GET /users/:id
  def show
    # fail
    @user = User.find(params[:id])
    @microposts = @user.microposts.paginate(page: params[:page])
  end

  private

  # it is essential that we only update attributes via mass assignment
  # that are safe to edit through the web.
  def user_params
    params.require(:user).permit(:first_name, :last_name, :email, :password,
                                 :password_confirmation)
  end

  # Confirms a user is the current user
  def require_correct_user
    @user = User.find(params[:id])
    redirect_to(root_url) unless current_user?(@user)
  end

  #
  def require_admin_user
    redirect_to(root_url) unless current_user.admin?
  end
end
