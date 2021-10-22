class ReplaceEmployeeProjectId < ActiveRecord::Migration[6.1]
  def up
    rename_column(:timesheets, :employee_project_id, :project_id)
    remove_column(:timesheets, :category)
    add_column(:timesheets, :task_type, :integer, null: false)
    add_column(:timesheets, :employee_id, :integer, null: false)
  end

  def down
    rename_column(:timesheets, :project_id, :employee_project_id)
    add_column(:timesheets, :category, :string)
    remove_column(:timesheets, :task_type)
    remove_column(:timesheets, :employee_id)
  end
end
