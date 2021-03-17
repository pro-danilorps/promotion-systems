class ChangePromotionDescriptionType < ActiveRecord::Migration[6.1]
  def change
    change_column :promotions, :description, :text
  end
end
