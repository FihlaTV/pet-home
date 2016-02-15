module ReviewsHelper
  def user_is_authorized_for_review?(review)
    current_user && (current_user == review.user) || current_user.admin?
  end
end
