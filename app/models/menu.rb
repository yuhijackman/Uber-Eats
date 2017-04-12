class Menu < ApplicationRecord
  belongs_to :restaurant
  has_many :favorites
  has_one :order
end
