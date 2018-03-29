class Report < ApplicationRecord
	belongs_to :reported, polymorphic: true
	belongs_to :user
end
