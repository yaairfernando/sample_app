class UsersController < ApplicationController
  before_action :set_user, only: %i[show edit update destroy]
  before_action :logged_in_user, only: %i[edit update]
  before_action :correct_user, only: %i[edit update]

  # GET /users
  def index
    @users = User.all
  end

  # GET /users/1
  def show; end

  # GET /users/new
  def new
    @user = User.new
  end

  # GET /users/1/edit
  def edit; end

  def create
    @user = User.new(user_params)
      if @user.save
        log_in @user
        flash[:success] = 'User was successfully created.'
        redirect_to @user
      else
        render :new 
      end
  end

  # PATCH/PUT /users/1
  def update
      if @user.update_attributes(user_params)
        flash[:success] = 'User was successfully updated.'
        redirect_to @user
      else
        render :edit
      end
  end

  # DELETE /users/1
  def destroy
    @user.destroy
    respond_to do |format|
      format.html { redirect_to users_url, notice: 'User was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_user
    @user = User.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end

  def logged_in_user
    unless logged_in?
      store_location
      flash[:danger] = "Please Log in!!!"
      redirect_to login_path
    end
  end

  def correct_user
    @user = User.find(params[:id])
    unless current_user?(@user)
      flash[:danger] = "You can not edit other users's info!!!"
      redirect_to root_path
    end
  end
end
