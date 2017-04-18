class Restaurant < ApplicationRecord
  has_many :menus
  has_many :favorites
  has_many :users
  has_many :likes, dependent: :destroy
  validates :name, presence: true
  scope :including_name_or_genre, ->(word){ where("name like '%" + word + "%'").or(Restaurant.where("genre like '%" + word + "%'")) }

  def like_user(user_id)
   likes.find_by(user_id: user_id)
  end

  def self.show_recommends(current_user, recommends_info)
    recommends_ids = []
    other_users_likes = []
    c_restaurants = []
    o_restaurants = []

    current_user_likes = current_user.likes
    current_user_likes.each do |c|
      item = c.restaurant_id
      c_restaurants << item
    end

    users = User.all
    other_users = users.reject { |u| u.id == current_user.id }
    other_users.each do |user|
      other_user_likes = user.likes
      other_user_likes.each do |o|
        item = o.restaurant_id
        o_restaurants <<  item
      end
    end

    if c_restaurants & o_restaurants
      recommend = o_restaurants - c_restaurants
      recommends_ids += recommend
    end

    dislike_restaurants = Dislike.where(user_id: current_user.id)
    recommends_ids.each do |r|
      e = []
      dislike_restaurants.each do |d|
        not_show = d.restaurant_id
        if r !=  not_show
          e << r
        end
      end
      if e.length == dislike_restaurants.length
        restaurant = Restaurant.find(r)
        recommends_info << restaurant
      end
    end
  end
end
