module ProjectsHelper

  def occupancy_level(project)
    return if project.id == Project.internal
    # 10% of required occupancy
    required_hours = project.working_hours_per_week.to_f
    buffer_required_hours = required_hours + (project.working_hours_per_week.to_f/10)
    actual_hours = project.total_occupied.to_f
    # over_occupied =
    # project.total_occupied.to_f < required_occupied ? 'row-green' : ''
    if(actual_hours > buffer_required_hours)
      return "#f0ad4e"
    elsif(actual_hours <= buffer_required_hours && actual_hours >= required_hours)
      return "#5bc0de"
    else
      return "#eeaba8"
      # normal
    end

  end

end
