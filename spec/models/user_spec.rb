require 'rails_helper'

RSpec.describe User, type: :model do
  let(:user) { User.create!(name: "User", email: "user@example.com", password: "helloworld") }

  it { is_expected.to have_many(:posts) }
  it { is_expected.to have_many(:reviews) }
end