class PostsController < ApplicationController
  def index
  	if !session[:user_id]
  		redirect_to '/'
  	end
  	@post = Post.all.joins(:user).select('posts.content, posts.id as id, posts.user_id, posts.like_count, users.alias as alias').order(like_count: :desc)
  	# render json: @post
  end
  def create
  	post = Post.new(content: params[:content], user_id: session[:user_id], like_count: 0)
  	if post.save
  		redirect_to :back
  	else
  		flash[:errors] = post.errors.full_messages
  		redirect_to :back
  	end
  end
  def destroy
  	post = Post.find(params[:id])
  	if post.user_id.to_i == session[:user_id].to_i
  		post.destroy
  	end
  	redirect_to :back
  end
end
