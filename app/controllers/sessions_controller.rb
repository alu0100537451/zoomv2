class SessionsController < ApplicationController
  def new
  end
 
  def create
    auth = request.env["omniauth.auth"]
    #user_facebook = User.from_omniauth(env["omniauth.auth"]) 
      if auth
        user = User.find_by(email: auth["info"]["email"]) || new_user = User.from_omniauth(auth)
        log_in user
        if new_user
          flash[:success] = "Bienvenido a Zoom"
        end
        redirect_back_or user
      else
        user = User.find_by(email: params[:session][:email].downcase)
        if user && user.authenticate(params[:session][:password])
          if user.activated?
            log_in user
            params[:session][:remember_me] == '1' ? remember(user) : forget(user)
            redirect_back_or user
      else
        message  = "La cuenta no está activada"
        message += "Revisa tu correo para activar la cuenta"
        flash[:warning] = message
        redirect_to root_url
      end
      else
        flash.now[:danger] = 'Combinación email/password inválida' # Not quite right!
        render 'new'
      end
    end
  end
  
  def destroy
    log_out if logged_in?
    redirect_to root_url
  end
end
