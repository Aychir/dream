class Post < ApplicationRecord
	has_one_attached :image

	validate :correct_image_type

	private

	def correct_image_type
		if image.attached? && !image.content_type.in?(%w(image/jpeg image/jpg image/png image/gif video/mp4))
			self.errors.add(:image, 'must be a JPEG, JPG or a PNG file')
		end
	end
end
