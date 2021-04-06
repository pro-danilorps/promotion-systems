class AddProductCategoryRefToPromotion < ActiveRecord::Migration[6.1]
  def change
    add_reference :promotions, :product_category, null: true, foreign_key: true
  end
end
