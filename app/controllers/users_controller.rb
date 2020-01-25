class UsersController < ApplicationController
  before_action :require_user, except: [:new, :create]
  before_action :set_user, only: [:show, :edit, :update, :destroy, :follow]
  before_action :require_same_user, only: [:edit, :update, :destroy]

  def index
    @users = User.all
  end

  def show
  end

  def new
    @user = User.new
  end

  def edit
  end

  def create
    @user = User.new(user_params)

    respond_to do |format|
      if @user.save
        session[:user_id] = @user.id
        format.html { redirect_to @user, flash: {success: 'Welcome in!'} }
        format.json { render :show, status: :created, location: @user }
      else
        format.html { render :new }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      image = user_params[:image]
      @user.image.attach(image) if image
      if @user.update(user_params)
        format.html { redirect_to @user, flash: {success: 'Profile updated.'} }
        format.json { render :show, status: :ok, location: @user }
      else
        format.html { render :edit }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @user.destroy
    message = 'Account deleted. Have fun out there 👋'
    respond_to do |format|
      format.html { redirect_to root_path, flash: {success: message} }
      format.json { render json: message, status: :ok }
    end
  end

  def follow
    current_user = get_current_user()
    message = ''

    if @user.followed_by?(current_user.id)
      current_user.unfollow(@user.id)
      message = "You unfollowed #{@user.username}"
    else
      current_user.follow(@user.id)
      message = "Now following #{@user.username}"
    end

    respond_to do |format|
      format.html { redirect_to @user, flash: {success: message} }
      format.json { render json: message, status: :ok }
    end
  end

  private
    def set_user
      @user = User.find(params[:id])
    end

    def user_params
      params.require(:user).permit(:username, :email, :full_name, :password, :avatar, :bio)
    end

    def require_same_user
      if !is_logged_in? || get_current_user != @user
        notice = "You can only edit or delete your own account."
        redirect_to root_path
      end
    end
end
