class CreateCompanies < ActiveRecord::Migration[8.0]
  def change
    create_table :companies do |t|
      t.string :title
      t.string :select_status

      t.timestamps
    end
  end
end
