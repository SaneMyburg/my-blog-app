class Api::V1::PostsController < ApplicationController
  def index
    user = User.find(params['user_id'])
    posts = user.posts
    render json: posts
  rescue ActiveRecord::RecordNotFound
    render json: { error: 'User not found' }, status: :not_found
  end
end
