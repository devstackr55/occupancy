class RemoveStateFromTimesheets < ActiveRecord::Migration[6.1]
  def change
    remove_column :timesheets, :state, :string
  end
end
