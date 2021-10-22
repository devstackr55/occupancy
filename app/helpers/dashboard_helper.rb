module DashboardHelper
  def employee_occupancy(skill_id)
    Employee.
    left_outer_joins(:employee_projects, :primary_skills).
    joins(:user).
    group("employees.id").
    where("skills.id = #{skill_id} and users.role = 'employee'").
    having("sum(employee_projects.weekly_occupancy) is null or sum(employee_projects.weekly_occupancy) < 10").
    select("employees.*, sum(employee_projects.weekly_occupancy) as total_allocation").length
  end
end
