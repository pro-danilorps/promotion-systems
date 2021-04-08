class CreateProductCategoriesAndPromotions < ActiveRecord::Migration[6.1]
  def change
    create_join_table :product_categories, :promotions do |t|
    end
  end
end
