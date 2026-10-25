class AddInterviewsToContents < ActiveRecord::Migration[8.0]
  def change
    add_column :interviews, :content, :string
  end
end
