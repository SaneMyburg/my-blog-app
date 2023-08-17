require 'rails_helper'

RSpec.describe Comment, type: :model do
  let(:user) { User.create(name: 'John', photo: 'https://unsplash.com/photos/F_-0BxGuVvo', bio: 'English teacher') }
  let(:post) { Post.new(author: user, title: 'title', text: 'text', comments_counter: 0, likes_counter: 0) }
  subject { Comment.new(text: 'This is a comment', author: user, post:) }

  before { subject.save }

  it 'new comment should be saved in the database' do
    expect(subject).to be_persisted
  end

  it 'text should be present' do
    subject.text = nil
    expect(subject).to_not be_valid
  end

  describe '#update_post_comments_counter' do
    it 'increments comments_counter' do
      expect { subject.post.comments.create(text: 'Another comment', author: user) }
        .to change { subject.post.comments_counter }.from(1).to(2)
    end
  end
end
