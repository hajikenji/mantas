class SessionController < ApplicationController
  skip_before_action :login_required, only: %i[new create]

  def new
    
  end

  def create
    flash.now[:danger] = 'ログインに失敗しました。'
    a = params[:session][:email].downcase
    user = User.find_by(email: a)
    if user && user.authenticate(params[:session][:password])
      session[:id] = user.id
      redirect_to user_path(user.id)
    else
      flash[:danger] = 'ログインに失敗しました。'
      redirect_to new_session_path
    end
  end

  def destroy
    session.delete(:id)
    flash[:notice] = 'ログアウトしました'
    
    redirect_to new_session_path
  end

end
