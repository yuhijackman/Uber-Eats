class Order < ApplicationRecord
  belongs_to :menu
  belongs_to :user
  belongs_to :restaurant
end
