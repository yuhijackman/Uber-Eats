class Menu < ApplicationRecord
  belongs_to :restaurant
  has_one :order
end
