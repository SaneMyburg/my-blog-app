require 'rails_helper'

RSpec.describe Like, type: :model do
  let(:user) { User.create(name: 'John', photo: 'https://unsplash.com/photos/F_-0BxGuVvo', bio: 'English teacher') }
  let(:post) { Post.new(author: user, title: 'title', text: 'text', comments_counter: 0, likes_counter: 0) }
  subject { Like.new(author: user, post:) }

  before { subject.save }

  it 'new like should be saved in the database' do
    expect(subject).to be_persisted
  end

  it 'should belong to a user' do
    like = Like.new(author: nil, post:)
    expect(like).to_not be_valid
  end

  it 'should belong to a post' do
    subject.post_id = nil
    expect(subject).to_not be_valid
  end

  describe '#update_post_likes_counter' do
    it 'like increment' do
      expect(subject.post.likes_counter).to eq(1)
      subject.update_post_likes_counter
      expect(subject.post.likes_counter).to eq(1)
    end
  end
end
