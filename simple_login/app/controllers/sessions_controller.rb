class SessionsController < ApplicationController
  # @sessions = session[:user_id] ||= []
  def signup
    @user = User.new
    # binding.pry
    # redirect_to home_path flash: {success: "You have successfully loged in"}
  end

  def login

  end

  def home

  end

  def create
    @user = User.new(user_params)

    if @user.save
      session[:user_id] = @user.id
      flash[:success] = "You are now logged in!"
      redirect_to home_path
    else
      render :signup
    end
  end

  def logout
    binding.pry
    session[:user_id] = nil
    flash[:notice] = "Logged out"
    redirect_to login_path
  end
  
  def attempt_login
    if params[:username].present? && params[:password].present?
      found_user = User.where(username: params[:username]).first
    if found_user
      authorized_user = found_user.authenticate(params[:password])
    if authorized_user
      redirect_to home_path, flash: {success: "You've successfully logged in"}
      session[:user_id] = authorized_user[:id]
    end
    end
    end
  end
  
  private
  
  def user_params
    params.require(:user).permit(:username, :password, :password_confirmation)
  end

  # confirm logged in method

  # 

end
