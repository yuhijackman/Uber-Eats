class Menu < ApplicationRecord
  belongs_to :restaurant
  has_one :catering
  has_many :favorites
  has_one :order
end
