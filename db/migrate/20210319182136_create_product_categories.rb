class CreateProductCategories < ActiveRecord::Migration[6.1]
  def change
    create_table :product_categories do |t|
      t.string :name, null: false
      t.string :code, null: false

      t.timestamps
    end
  end
end
