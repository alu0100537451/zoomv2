class AccountActivationsController < ApplicationController

  def edit
    user = User.find_by(email: params[:email])
    if user && !user.activated? && user.authenticated?(:activation, params[:id])
      user.activate
      log_in user
      flash[:success] = "Tu cuenta ha sido activada con éxito"
      redirect_to user
    else
      flash[:danger] = "Link de activación de cuenta incorrecto"
      redirect_to root_url
    end
  end
end
