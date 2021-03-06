class SessionsController < ApplicationController
  skip_before_action :login_required

  def new
    render layout: 'login'
  end

  def create
    user = User.find_by(email: session_params[:email], state: true)

    if user&.authenticate(session_params[:password])
      session[:user_id] = user.id
      redirect_to root_url, notice: 'ログインしました。'
    else
      flash.now.alert = 'メールアドレスまたはパスワードが間違っています。'
      render :new, layout: 'login'
    end
  end

  def destroy
    reset_session
    redirect_to root_url, notice: 'ログアウトしました。'
    # render layout: 'login'
  end

  # private

  private def session_params
    params.require(:session).permit(:email, :password)
  end

end
