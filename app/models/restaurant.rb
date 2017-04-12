class Restaurant < ApplicationRecord
  has_many :menus
  has_many :favorites
  validates :name, presence: true
  scope :including_name_or_genre, ->(word){ where("name like '%" + word + "%'").or(Restaurant.where("genre like '%" + word + "%'")) }
end
