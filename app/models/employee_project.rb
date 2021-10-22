class EmployeeProject < ApplicationRecord
  belongs_to :employee
  belongs_to :project
  has_many :timesheets

  enum role: %i[Co-ordinator Developer Both]

  validates :weekly_occupancy, numericality: {less_than_or_equal_to: 40}
end
