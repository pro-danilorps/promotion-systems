class AddUniqToProductCategoryCode < ActiveRecord::Migration[6.1]
  def change
    add_index :product_categories, :code, unique: true
  end
end
