class RemoveDefaultFromUserFkOnPromotion < ActiveRecord::Migration[6.1]
  def change
    change_column_default(:promotions, :user_id, nil)
  end
end
