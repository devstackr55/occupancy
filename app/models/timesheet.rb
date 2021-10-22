class Timesheet < ApplicationRecord
  belongs_to :employee
  belongs_to :project
  belongs_to :invoice, optional: true
  # enum category: { development: "development", client_meeting: "client_meeting", internal_meeting: "internal_meeting", client_interviews: "client_interviews", interviews: "interviews", others: "others" }
  enum task_type: ["Development", "Project Meeting", "Internal Meeting", "Client Interview", "Interview", "Other"]
  validates :working_hours, :on_date, :comments, presence: true

  # delegate :employee, to: :employee_project
  # delegate :project, to: :employee_project

  validate :task_type_for_project

  def raised_timesheets
    project.timesheets.where(invoice_raised: true).where("on_date <= ? AND on_Date >= ?", end_date, start_date )
  end

  def task_type_for_project
    internal_project_id = Project.internal
    allowed_tasks = ["Internal Meeting", "Client Interview", "Interview", "Other"]
    if project_id != internal_project_id && allowed_tasks.include?(task_type)
      errors.add(:task_type, "'#{task_type}' is only allowed for Internal Project")
    end
  end

end
