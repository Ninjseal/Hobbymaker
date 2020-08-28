class Country < ApplicationRecord
  has_many :users
  has_many :regions, dependent: :destroy

  validates_presence_of :name, :abbrev

  scope :order_by_name, -> { order("name asc") }
end
