class Admin::UsersController < ApplicationController
  before_action :admin?
  def index
    @users = User.all
  end

  def new
    @user = User.new
  end

  def show
    @user = User.find(params[:id])
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update(admin_params)
      redirect_to action: :index
    else
      render 'edit'
    end
  end

  def create
    user = User.new(admin_params)
    user.save
    redirect_to admin_users_path
  end

  def destroy
    @user = User.find(params[:id])
    @user.destroy
    redirect_to admin_users_path
  end

  private
    def admin_params
      params.require(:user).permit(:name, :lastname, :email, :gender, :age, :password)
    end

    def admin?
      if current_user.admin
        true
      else
        redirect_to users_path
      end
    end
end
