class Country < ApplicationRecord
  has_many :users
  has_many :regions, dependent: :destroy

  scope :order_by_name, -> { order("name asc") }
end
