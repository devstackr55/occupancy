class CreateEmployeeProjects < ActiveRecord::Migration[6.1]
  def change
    create_table :employee_projects do |t|
      t.belongs_to :employee, foreign_key: true
      t.belongs_to :project, foreign_key: true
      # In hours should not be > 40 hrs
      t.integer :weekly_occupancy
      t.datetime :start_at
      # nill value shows an indefinate time
      t.datetime :ended_on
      # Co-ordinator, Developer
      t.integer :role
      t.string :comments
      t.timestamps
    end
  end
end
