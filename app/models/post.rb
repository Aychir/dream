require_relative '/Users/chiriac/.rbenv/versions/2.5.0/lib/ruby/gems/2.5.0/gems/file_validators-2.3.0/lib/file_validators.rb' 
class Post < ApplicationRecord

	belongs_to :user

	has_many :reports
  	has_many :reports, as: :reported_content

	has_one_attached :image

	validate :image_attached

	validate :correct_image_type

	validate :correct_image_size

	serialize :tags, Array

	private

	def image_attached
		if !image.attached?
			image.purge
			self.errors.add(:post, "must be attached!")
		end
	end

	def correct_image_type
		if image.attached? && !image.content_type.in?(%w(image/jpeg image/jpg image/png image/gif video/mp4))
			image.purge
			self.errors.add(:image, 'must be a JPEG, JPG, PNG or MP4 file')
		end
	end

	def correct_image_size
		if image.attached?
			if image.blob.byte_size > 4244635648
				self.errors.add(:post, "is too big, upload a file smaller than 4GB.") 
			end
		end
	end
end
