class PostsController < ApplicationController
  def index
    @user = User.find(params[:user_id])
    @posts = @user.posts.includes(:comments, author: :comments)
  end

  def show
    @post = Post.find(params[:id])
    @user = @post.author
    @comments = @post.recent_comments
  end

  def new
    @user = User.find(params[:user_id])
    @post = @user.posts.build
  end

  def create
    @post = current_user.posts.build(post_params)

    if @post.save
      redirect_to user_path(@post.author), notice: 'Post was successfully created.'
    else
      render :new
    end
  end

  def destroy
    @post = Post.find(params[:id])
    @user = @post.author
    puts "Destroy action called"
    if @post.destroy
      redirect_to user_posts_path, notice: "Post was successfully deleted."
    else
      redirect_to user_posts_path, alert: "Error deleting the post."
    end
  end

  private

  def post_params
    params.require(:post).permit(:title, :text)
  end
end
