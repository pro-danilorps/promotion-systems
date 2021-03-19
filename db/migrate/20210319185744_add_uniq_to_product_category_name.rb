class AddUniqToProductCategoryName < ActiveRecord::Migration[6.1]
  def change
    add_index :product_categories, :name, unique: true
  end
end
