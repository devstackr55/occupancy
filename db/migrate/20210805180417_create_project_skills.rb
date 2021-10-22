class CreateProjectSkills < ActiveRecord::Migration[6.1]
  def change
    create_table :project_skills do |t|
      t.belongs_to :project, foreign_key: true
      t.belongs_to :skill, foreign_key: true
      t.integer :quantity, default: 1
      t.timestamps
    end
  end
end
