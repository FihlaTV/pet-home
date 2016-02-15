require 'rails_helper'

RSpec.describe Post, type: :model do
  let(:category) { Category.create!(name: "category") }
  let(:user) { User.create!(name: "User", email: "user@example.com", password: "helloworld") }
  let(:post) { category.posts.create!(title: "post title", body: "post really long random body", user:user) }

  it { is_expected.to have_many(:reviews) }
end