class Favorite < ApplicationRecord
  belongs_to :user
  belongs_to :menu
  belongs_to :restaurant
end
