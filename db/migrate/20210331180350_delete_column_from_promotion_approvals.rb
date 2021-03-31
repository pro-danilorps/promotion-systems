class DeleteColumnFromPromotionApprovals < ActiveRecord::Migration[6.1]
  def change
    remove_column :promotion_approvals, :promotion_approval
  end
end
