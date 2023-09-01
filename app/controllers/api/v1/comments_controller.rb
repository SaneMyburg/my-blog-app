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
    token = request.headers['X-Token']
    user = User.find_by(api_token: token)
    post = Post.find(params['post_id'])

    new_comment = Comment.new(
      text: params['text'],
      author: user, # Set the author of the comment
      post: # Associate the comment with the post
    )

    if new_comment.save
      render json: { success: 'Comment added successfully' }, status: :created
    else
      render json: { error: new_comment.errors.full_messages }, status: :bad_request
    end
  rescue ActiveRecord::RecordNotFound
    render json: { error: 'User or Post not found' }, status: :not_found
  end
end
