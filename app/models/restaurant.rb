class Restaurant < ApplicationRecord
  has_many :menus
  validates :name, presence: true
  scope :including_name_or_genre, ->(word){ where("name LIKE ?", word) or where("genre LIKE ?", word) }
end
