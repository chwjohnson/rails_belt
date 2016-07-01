class UsersController < ApplicationController
  def create
  	user = User.new(user_params)
  	if user.save
  		session[:user_id] = user.id
  		session[:name] = user.name
  		redirect_to '/posts'
  	else
  		flash[:errors] = user.errors.full_messages
  		redirect_to '/'
  	end
  end
  def show
  	@user = User.where(id: params[:id]).select("users.name as name, users.alias as alias, users.email as email")
  	post = Post.where(user_id: params[:id])
  	@like_total = 0
  	@post_total = 0
  	post.each do |count|
  		@post_total += 1
  		@like_total += count.like_count
  	end
  	# render json: @post_total
  end
  private
  	def user_params
  		params.require(:user).permit(:name, :alias, :password, :password_confirmation, :email)
  	end
end
