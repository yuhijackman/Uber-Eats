class Restaurant < ApplicationRecord
  has_many :menus
  has_many :favorites
  validates :name, presence: true
  scope :including_name_or_genre, ->(word){ where("name like '%" + word + "%'").or(Restaurant.where("genre like '%" + word + "%'")) }

  # def self.show_favorites(user_id)
  #   favorites = Favorite.where(user_id: user_id, created_at: 1.week.ago..Time.current)
  #   if favorites.present?
  #     menu_ids = favorites.group(:menu_id).order('count_menu_id DESC').limit(3).count(:menu_id).keys
  #     @favorites = menu_ids.map{ |id| Favorite.find_by(menu_id: id) }
  #   else
  #     @favorites = Favorite.where(user_id: current_user.id).last(3)
  #   end
  # end
end
