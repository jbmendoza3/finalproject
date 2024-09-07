class Cart < ApplicationRecord
  belongs_to :user
  has_many :cart_items, dependent: :destroy
  
  def total_price
    cart_items.joins(:item).sum('cart_items.quantity * items.price')
  end
end
