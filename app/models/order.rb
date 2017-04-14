class Order < ApplicationRecord
  belongs_to :menu
  belongs_to :user
  belongs_to :restaurant
  # after_create :auto_favorite

  def self.auto_favorite(order, user_id)
    menu_id  = order.menu_id
    orders   = Order.where(user_id: user_id, menu_id: menu_id, created_at: 5.days.ago..Time.current)
    if orders.count == 5
      Favorite.create(menu_id: menu_id, user_id: user_id)
    end
  end

end
