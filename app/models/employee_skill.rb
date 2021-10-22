class EmployeeSkill < ApplicationRecord
  belongs_to :skill
  belongs_to :employee

  validates :skill_id, uniqueness: {:scope => :employee_id}
end
