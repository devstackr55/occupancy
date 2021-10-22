json.array!(@timesheets) do |timesheet|
  json.title "#{timesheet.project.name} #{timesheet.working_hours} #{timesheet.working_hours > 1 ? 'hours' : 'hour'}"
  json.start timesheet.on_date
  json.backgroundColor color_pallet(timesheet.task_type)
end
