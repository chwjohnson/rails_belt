class LikesController < ApplicationController
  def show
  	@post = Post.where(id: params[:id]).joins(:user).select('posts.content, posts.id as id, posts.user_id, posts.like_count, users.alias as alias').order(like_count: :desc)
  	@likes = Like.joins(:user).where(post_id: params[:id]).select("users.alias as alias, users.name as name, users.id as user_id")
  	# render json: @likes
  end
  def create
  	like_check = Like.where(user_id: session[:user_id])
  	check = false
  	# render json: like_check
  	if like_check
  		like_check.each do |c|
  			if c.post_id.to_i == params[:id].to_i
  				check = true
  			end
  		end
  	end
  	if check
  		flash[:errors] = ["You have already liked this post"]
  	else
	  	like = Like.new(user_id: session[:user_id], post_id: params[:id])
	  	post = Post.find(params[:id])
	  	post.like_count += 1
	  	post.save
	  	like.save
  	end
  	redirect_to :back
  end
end
