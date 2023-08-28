require 'rails_helper'

RSpec.describe 'Users', type: :request do
  let!(:user) { User.create!(name: 'John', posts_counter: 0) }

  describe 'GET /users' do
    it 'should return a 200 OK status' do
      get users_path
      expect(response).to have_http_status(200)
    end

    it 'should render users/index template' do
      get users_path
      expect(response).to render_template('index')
    end
  end

  describe 'Get /users/:id' do
    it 'should return a 200 OK status' do
      get user_url(user)
      expect(response).to have_http_status(200)
    end

    it 'should render users/show template' do
      get user_url(user)
      expect(response).to render_template('show')
    end
  end
end
