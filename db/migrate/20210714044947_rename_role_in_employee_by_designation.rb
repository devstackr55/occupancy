class RenameRoleInEmployeeByDesignation < ActiveRecord::Migration[6.1]
  def change
    rename_column :employees, :role, :desigation
  end
end
