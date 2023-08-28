require 'rails_helper'

RSpec.describe 'Posts', type: :request do
  let!(:user) { User.create(name: 'John', posts_counter: 0, photo: 'https://unsplash.com/photos/F_-0BxGuVvo') }
  let!(:post) do
    Post.create(author: user, title: 'My new blog', text: 'This is my first blog', likes_counter: 0,
                comments_counter: 0)
  end

  describe 'GET /users/:user_id/posts' do
    it 'should return a 200 ok status' do
      get user_posts_path(user_id: user.id)
      expect(response).to have_http_status(200)
    end

    it 'should render posts/index template' do
      get user_posts_path(user_id: user.id)
      expect(response).to render_template('index')
    end
  end

  describe 'GET users/:user_id/posts/:id' do
    it 'should return a 200 ok status' do
      get user_post_path(user_id: user.id, id: post.id)
      expect(response).to have_http_status(200)
    end

    it 'should render posts/show template' do
      get user_post_path(user_id: user.id, id: post.id)
      expect(response).to render_template('show')
    end
  end
end
