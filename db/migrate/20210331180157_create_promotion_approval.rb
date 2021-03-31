class CreatePromotionApproval < ActiveRecord::Migration[6.1]
  def change
    create_table :promotion_approvals do |t|
      t.string :promotion_approval
      t.references :promotion, null: false, foreign_key: true
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
