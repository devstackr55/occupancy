class AddFewColumsInEmployee < ActiveRecord::Migration[6.1]
  def up
    add_column(:employees, :ctc_per_day, :decimal, precision: 4, scale: 2)
    add_column(:employees, :last_working_day, :date)
    add_column(:employees, :development_skill, :integer, default: 0)
    add_column(:employees, :client_management_skill, :integer, default: 0)
    add_column(:employees, :mentorship_skill, :integer, default: 0)

    add_column :employee_skills, :is_primary, :boolean, default: true
  end

  def down
    remove_column(:employees, :ctc_per_day)
    remove_column(:employees, :last_working_day)
    remove_column(:employees, :development_skill)
    remove_column(:employees, :client_management_skill)
    remove_column(:employees, :mentorship_skill)

    remove_column :employee_skills, :is_primary
  end

end
