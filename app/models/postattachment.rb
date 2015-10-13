class Postattachment < ActiveRecord::Base
  mount_uploader :picture, PictureUploader
  belongs_to :post
  validate :picture_size

  private

  def picture_size
    if picture.size > 5.megabytes
      errors.add(:picture, "should be less than 3MB")
    end
  end
end
