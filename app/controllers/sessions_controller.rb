class SessionsController < ApplicationController
  def new
  end

  def create
    # render plain: params[:session].inspect
    user = User.find_by(email: params[:session][:email].downcase)
    if user && user.authenticate(params[:session][:password])
      log_in user
      redirect_to user
      # render html: 'Yes'
    else
      flash.now[:danger] = "Password or email are invalid!!.. Try again please"
      render 'new'
    end
  end
end
