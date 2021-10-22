class DashboardController < ApplicationController
  before_action :authenticate_user!
  # load_and_authorize_resource


  def index
    @client_count = Client.count
    @projects_count = Project.count
    @total_employees = Employee.count
    #  Employee.left_outer_joins(:projects).group("employees.id").select("employees.name as name", "employees.email as email", "count(projects.id) as total_projects")
    # available / on bench
    @available_employees = Employee.joins(:user).left_outer_joins(:employee_projects)
    .group("employees.id")
    .having("sum(employee_projects.weekly_occupancy) is null or sum(employee_projects.weekly_occupancy) <= 5")
    .where("users.role = 'employee'")
    .select("employees.*, sum(employee_projects.weekly_occupancy) as total_allocation")
    # 0 > and < 30
    @overloaded_employees = Employee.joins(:user).left_outer_joins(:employee_projects)
    .group("employees.id")
    .where("users.role = 'employee'")
    .having("sum(employee_projects.weekly_occupancy) > 44")
    .select("employees.*, sum(employee_projects.weekly_occupancy) as total_allocation")

    @skills = Skill.left_outer_joins(:primary_employees).group("skills.id").select("skills.*, count(employees.id) as total_employees")
    # Employee.joins(:employee_projects).group("employees.id").having("sum(employee_projects.weekly_occupancy) > 0 and sum(employee_projects.weekly_occupancy) < 20").select("employees.*, sum(employee_projects.weekly_occupancy) as total_allocation")
  end

end
