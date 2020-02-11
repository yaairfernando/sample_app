class SessionsController < ApplicationController
  def new; end

  def create
    # render plain: params[:session].inspect
    user = User.find_by(email: params[:session][:email].downcase)
    if user && user.authenticate(params[:session][:password])
      if user.activated?
        log_in user
        params[:session][:remember_me] == "1" ? remember(user) : forget(user)
        redirect_back_or user
        # render html: 'Yes'
      else
        message = "Account not activated."
        message += "Check you email for the activation link."
        flash[:warning] = message
        redirect_to root_path
      end
    else
      flash.now[:danger] = 'Password or email are invalid!!.. Try again please'
      render 'new'
    end
  end

  def destroy
    log_out if logged_in?
    redirect_to root_path
  end
end
