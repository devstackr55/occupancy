class CreateTimesheets < ActiveRecord::Migration[6.1]
  def change
    create_table :timesheets do |t|
      t.integer :employee_project_id
      t.decimal :billing_hours, precision: 4, scale: 2
      t.decimal :working_hours, precision: 4, scale: 2
      t.date :on_date
      t.text :comments
      t.text :references
      t.string :state

      t.timestamps
    end
  end
end
