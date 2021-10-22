class Project < ApplicationRecord
  attr_accessor :skill_ids

  enum category: %i[iGamming Agency Internal]
  enum payment_cycle: %w{Weekly Bi-Weekly Monthly Custom}

  belongs_to :client

  has_many :employee_projects
  has_many :employees, through: :employee_projects

  has_many :project_skills
  has_many :skills, through: :project_skills

  has_many :invoices
  has_many :timesheets

  validates :name, presence: true
  validates :name, uniqueness: true

  after_commit :update_skills, on: [:create, :update]

  def self.all_project_time
    self.all.select("sum(working_hours_per_week) as total_project_time")[0]["total_project_time"]
  end

  # total resources occupied
  def total_occupied
    employee_projects.select("sum(weekly_occupancy) as total_occupied")[0]["total_occupied"]
  end

  def self.internal
    find_by(name: "Internal").try(:id)
  end

  # last paid invoice
  def last_paid
    invoices.where(status: 'Paid').order(:paid_at).try(:first)
  end

  private
  def update_skills
    # [{skill_id: 1, quantity: 1}]
    # skill_ids

    # exist_skill_ids = skills.pluck(:id)
    # exist_skill_ids.concat(skill_ids)
    return if skill_ids.blank?
    project_skills.destroy_all
    skill_ids.each do |sk|
      ProjectSkill.create(project_id: id, skill_id: sk[:skill_id], quantity: sk[:quantity])
    end
  end

end
