class AddDiscountLimitToPromotion < ActiveRecord::Migration[6.1]
  def change
    add_column :promotions, :discount_limit, :decimal
  end
end
