require 'rails_helper'

RSpec.describe Review, type: :model do
  let(:category) { Category.create!(name: "Category") }
  let(:user) { User.create!(name: "User", email: "user@example.com", password: "helloworld") }
  let(:post) { category.posts.create!(title: "post_title", body: "post really long random body", user:user) }
  let(:review) { Review.create!(body: 'Comment body', post: post, user: user) }

  it { is_expected.to belong_to(:post) }
  it { is_expected.to belong_to(:user) }

  it { is_expected.to validate_presence_of(:body)}
  it { is_expected.to validate_length_of(:body).is_at_least(5)}

  describe "attributes" do
    it "responds to body" do
      expect(review).to respond_to(:body)
    end
  end
end
