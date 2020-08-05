class City < ApplicationRecord
  belongs_to :region
  has_many :events, dependent: :destroy
end
