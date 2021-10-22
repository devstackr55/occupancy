class AddFieldsToTimesheet < ActiveRecord::Migration[6.1]
  def change
    add_column :timesheets, :invoice_id, :integer
    add_column :timesheets, :category, :string
  end
end
