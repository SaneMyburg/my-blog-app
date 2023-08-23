class LikesController < ApplicationController
  def create
    @user = User.find(params[:user_id])
    @post = Post.find(params[:post_id])
    @like = current_user.likes.build(post: @post)

    if @like.save
      redirect_to user_post_path(@user, @post), notice: 'Post liked!'
    else
      redirect_to user_post_path(@user, @post), alert: 'Failed to like the post.'
    end
  end

  def like
    @user = User.find(params[:user_id])
    @post = Post.find(params[:id])

    if current_user.likes.where(post: @post).exists?
      redirect_to user_post_path(@user, @post), alert: 'You have already liked this post.'
    else
      @post.increment!(:likes_counter)
      redirect_to user_post_path(@user, @post), notice: 'Post liked!'
    end
  end
end
