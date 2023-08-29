require 'rails_helper'

RSpec.describe User, type: :model do
  subject { User.new(name: 'John', photo: 'https://unsplash.com/photos/F_-0BxGuVvo', bio: 'English teacher.') }

  before { subject.save }

  it 'name should be present' do
    subject.name = nil
    expect(subject).to_not be_valid
  end

  it 'posts_counter should be an integer' do
    subject.posts_counter = 'a'
    expect(subject).to_not be_valid
  end

  it 'posts_counter should be greater than or equal to 0' do
    subject.posts_counter = -1
    expect(subject).to_not be_valid
  end

  describe '#recent_posts' do
    let(:user) { User.create(name: 'John', photo: 'https://unsplash.com/photos/F_-0BxGuVvo', bio: 'English teacher.') }

    it 'returns recent posts in descending order' do
      post1 = Post.create(author: user, title: 'First Post', text: 'Hello', comments_counter: 0, likes_counter: 0,
                          created_at: 4.days.ago)
      post2 = Post.create(author: user, title: 'Second Post', text: 'Hello', comments_counter: 0, likes_counter: 0,
                          created_at: 3.days.ago)
      post3 = Post.create(author: user, title: 'Third Post', text: 'Hello', comments_counter: 0, likes_counter: 0,
                          created_at: 2.days.ago)
      Post.create(author: user, title: 'Fourth Post', text: 'Hello', comments_counter: 0, likes_counter: 0,
                  created_at: 1.day.ago)
      expect(user.recent_posts).to eq([post1, post2, post3])
    end
  end
end
