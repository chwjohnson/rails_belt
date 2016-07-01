class SessionsController < ApplicationController
  def index
  end
  def create
  	user = User.find_by(email: params[:user][:email])
  	if user && user.authenticate(params[:user][:password])
  		session[:user_id] = user.id
  		session[:name] = user.name
  		redirect_to '/posts'
  	else
  		flash[:error] = "Invalid Credentials"
  		redirect_to '/'
  	end
  end
  def destroy
  	reset_session
  	redirect_to '/'
  end
end
