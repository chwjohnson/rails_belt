class LoginsController < ApplicationController
  def index
  end
  def new
  end
  def destroy
  	reset_session
  	redirect_to root_path
  end
  def create
  	user1 = Lender.find_by(email: params[:email])
  	user2 = Borrower.find_by(email: params[:email])
  	if user1
  		if user1.authenticate(params[:password])
  			session[:id] = user1.id
  			session[:type] = "lender"
  			session[:name] = "#{user1.first_name} #{user1.last_name}"
  			redirect_to "/lenders/#{session[:id]}"
  		else
  			flash[:errors] = "Invalid Credentials!"
  			redirect_to :back
  		end
  	elsif user2
  		if user2.authenticate(params[:password])
  			session[:id] = user2.id
	  		session[:type] = "borrower"
	  		session[:name] = "#{user2.first_name} #{user2.last_name}"
	  		redirect_to "/borrowers/#{session[:id]}"
  		else
  			flash[:errors] = "Invalid Credentials!"
  			redirect_to :back
  		end
  	else
  		flash[:errors] = "Invalid Credentials!"
  		redirect_to :back
  	end

  end
end
