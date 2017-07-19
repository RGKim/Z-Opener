class Image < ApplicationRecord
  has_many :orders, dependent: :destroy
end
