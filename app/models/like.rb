class Like < ApplicationRecord
  belongs_to :restaurant, counter_cache: :likes_count
  belongs_to :user
end
