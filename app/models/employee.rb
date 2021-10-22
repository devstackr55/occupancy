class Employee < ApplicationRecord
  attr_accessor :primary_skill_id, :role
  enum  designation: %i[TeamLead TechLead SSE SE]

  has_one :user, dependent: :destroy
  # skills
  has_many :employee_skills, dependent: :destroy
  has_many :skills, through: :employee_skills

  has_many :primary_skills, -> { where("employee_skills.is_primary is true")},:through => :employee_skills,  source: :skill
  has_many :secondary_skills, -> { where("employee_skills.is_primary is not true")},:through => :employee_skills,  source: :skill

  has_many :employee_projects
  has_many :projects, through: :employee_projects

  has_many :timesheets

  validates :name, :email, :designation, presence: true
  validates :email, uniqueness: true

  after_create :create_user
  after_commit :update_skill, on: [:create, :update]

  def weekly_occupancy
    employee_projects.pluck(:weekly_occupancy).sum
  end

  def available_occupancy
    # Employee.joins(:employee_projects).select("sum(weekly_occupancy) as total, (count(employees.id)*40) as available_time")
    40 - weekly_occupancy
  end

  # get the overall timelogs on given date
  # date formate should be "YYYY-MM-DD"
  def timelogs_on_day(date)
    timesheets.where(on_date: date).pluck(:working_hours).sum
  end

  private
  def create_user
    User.create!(employee_id: id, password: 'password', password_confirmation: 'password', email: email, role: role)
  end

  def update_skill
    unless primary_skill_id.nil?
      primary_skill = employee_skills.new(is_primary: true, skill_id: primary_skill_id)
      primary_skill.save
    end
  end

end
