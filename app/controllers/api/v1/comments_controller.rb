class Api::V1::CommentsController < ApplicationController
  skip_before_action :verify_authenticity_token, only: [:create], if: -> { request.format.json? }

  def index
    post = Post.find(params['post_id'])
    comments = post.comments
    render json: comments
  rescue ActiveRecord::RecordNotFound
    render json: { error: 'Post not found' }, status: :not_found
  end

  def create
    user_id = params['user_id']
    post = Post.find(params['post_id'])

    user = User.find(user_id)

    if user.nil?
      render json: { error: 'User not found' }, status: :not_found
      return
    end

    new_comment = post.comments.new(
      text: params['text'],
      author: user,
      post:
    )

    if new_comment.save
      render json: { success: 'Comment added successfully' }, status: :created
    else
      render json: { error: new_comment.errors.full_messages }, status: :bad_request
    end
  rescue ActiveRecord::RecordNotFound
    render json: { error: 'Post not found' }, status: :not_found
  end
end
