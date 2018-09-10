class Vote < ApplicationRecord
  belongs_to :user
  belongs_to :post

  validates :post, uniqueness: { scope: :user }
  validates :user, uniqueness: { scope: :post }
end
