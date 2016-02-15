require 'rails_helper'
include SessionsHelper

RSpec.describe ReviewsController, type: :controller do
  let(:my_user) { User.create!(name: "User", email: "user@example.com", password: "helloworld") }
  let(:other_user) { User.create!(name: "Other User", email: "otheruser@example.com", password: "helloworld") }
  let(:my_category) { Category.create!(name: "Category") }
  let(:my_post) {  my_category.posts.create!(title: "Post title", body: "post really long random body", user: my_user) }
  let(:my_review) { Review.create!(body: 'Comment body', post: my_post, user: my_user) }

  context "guest" do
    describe "POST create" do
      it "redirects the user to the sign in view" do
        post :create, post_id: my_post.id, review: {title: "New Comment", body: "New comment body"}
        expect(response).to redirect_to(login_path)
      end
    end

    describe "DELETE destroy" do
      it "redirects the user to the sign in view" do
        delete :destroy, post_id: my_post.id, id: my_review.id
        expect(response).to redirect_to(login_path)
      end
    end
  end

  context "member user doing CRUD on a comment they don't own" do
    before do
      log_in(other_user)
    end

    describe "POST create" do
      it "increases the number of reviews by 1" do
        expect { post :create, post_id: my_post.id, review: {body: "New test review"} }.to change(Review, :count).by(1)
      end

      it "redirects to the post show view" do
        post :create, post_id: my_post.id, review: {body: "New test review"}
        expect(response).to redirect_to [my_category, my_post]
      end
    end

    describe "DELETE destroy" do
      it "redirects the user to the post show view" do
        delete :destroy, post_id: my_post.id, id: my_review.id
        expect(response).to redirect_to [my_category, my_post]
      end
    end
  end

  context "member user doing CRUD on a review they own" do
    before do
      log_in(my_user)
    end

    describe "POST create" do
      it "increases the number of reviews by 1" do
        expect { post :create, post_id: my_post.id, review: {body: "New member review"} }.to change(Review, :count).by(1)
      end

      it "redirects to the post show view" do
        post :create, post_id: my_post.id, review: {body: "New member review"}
        expect(response).to redirect_to [my_category, my_post]
      end
    end

    describe "DELETE destroy" do
      it "deletes the review" do
        delete :destroy, post_id: my_post.id, id: my_review.id
        count = Review.where({id: my_review.id}).count
        expect(count).to eq(0)
      end

      it "redirects the user to the post show view" do
        delete :destroy, post_id: my_post.id, id: my_review.id
        expect(response).to redirect_to [my_category, my_post]
      end
    end
  end

  context "admin user doing CRUD on a review they don't own" do
    before do
      other_user.toggle!(:admin)
      log_in(other_user)
    end

    describe "POST create" do
      it "increases the number of reviews by 1" do
        expect { post :create, post_id: my_post.id, review: {body: "New member review"} }.to change(Review, :count).by(1)
      end

      it "redirects to the post show view" do
        post :create, post_id: my_post.id, review: {body: "New member review"}
        expect(response).to redirect_to [my_category, my_post]
      end
    end

    describe "DELETE destroy" do
      it "deletes the review" do
        delete :destroy, post_id: my_post.id, id: my_review.id
        count = Review.where({id: my_review.id}).count
        expect(count).to eq(0)
      end

      it "redirects the user to the post show view" do
        delete :destroy, post_id: my_post.id, id: my_review.id
        expect(response).to redirect_to [my_category, my_post]
      end
    end
  end
end
