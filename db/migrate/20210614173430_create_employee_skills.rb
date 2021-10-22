class CreateEmployeeSkills < ActiveRecord::Migration[6.1]
  def change
    create_table :employee_skills do |t|
      t.belongs_to :employee, foreign_key: true
      t.belongs_to :skill, foreign_key: true
      t.integer :experience
      t.timestamps
    end
  end
end
