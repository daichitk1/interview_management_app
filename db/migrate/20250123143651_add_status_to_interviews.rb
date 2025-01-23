class AddStatusToInterviews < ActiveRecord::Migration[8.0]
  def change
    add_column :interviews, :status, :integer
  end
end
