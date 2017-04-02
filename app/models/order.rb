class Order < ApplicationRecord
  has_many :menus
  belongs_to :user
  belongs_to :restaurant
end
