class TimesheetsController < ApplicationController
  before_action :authenticate_user!
  load_and_authorize_resource :employee
  load_and_authorize_resource :timesheet, through: :employee

  def index
    @timesheets = get_timesheet_data
    @timesheet = Timesheet.new(employee_id: @employee.id)
    respond_to do |format|
      format.json
      format.html
      format.csv { send_data @timesheets.to_csv, filename: "users-#{Date.today}.csv" }
    end
  end

  def show
  end

  def new
    @timesheets = get_timelogs(params[:on_date])
    @timesheet = Timesheet.new
  end

  def edit
  end

  def create
    @timesheet =  @employee.timesheets.build(timesheet_params)
    respond_to do |format|
      if @timesheet.save
        @timesheets = get_timelogs(@timesheet.on_date.strftime('%F'))
        new_form()
        format.html { redirect_to employee_timesheets_path(@employee), notice: "Timesheet was successfully created." }
        format.json { render :show, status: :created, location: @timesheet }
        format.js
      else
        @timesheets = get_timelogs(@timesheet.on_date.strftime('%F'))
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @timesheet.errors, status: :unprocessable_entity }
        format.js {render :error}
      end
    end
  end

  def update
    respond_to do |format|
      if @timesheet.update(timesheet_params)
        @timesheets = get_timelogs(@timesheet.on_date.strftime('%F'))
        new_form()
        # format.html { redirect_to @timesheet, notice: "Timesheet was successfully updated." }
        format.json { render :show, status: :ok, location: @timesheet }
        format.js {render :create}
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @timesheet.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @timesheets = get_timelogs(@timesheet.on_date.strftime('%F'))
    @timesheet.destroy
    respond_to do |format|
      # format.html { redirect_to timesheets_url, notice: "Timesheet was successfully destroyed." }
      format.json { head :no_content }
      format.js
    end
  end

  private
    def new_form
      @new_timesheet = Timesheet.new(employee_id: @employee.id)
    end

    def get_timesheet_data
      start_date = params[:start] || Date.today.at_beginning_of_month - 6.days
      end_date = params[:end] || Date.today.at_end_of_month + 6.days
      start_date = Date.parse(start_date.to_s).strftime("%F")
      end_date = Date.parse(end_date.to_s).strftime("%F")
      return @employee.timesheets.where("on_date >= '#{start_date}' and on_date <= '#{end_date}'")
    end

    def get_timelogs(on_date)
      @employee.timesheets.where('on_date = ?', on_date)
    end

    def get_employee
      @employee = Employee.find(params[:employee_id])
    end

    def set_timesheet
      @timesheet = Timesheet.find(params[:id])
    end

    def timesheet_params
      params.require(:timesheet).permit(:employee_id, :project_id, :working_hours, :on_date, :comments, :references, :task_type)
    end
end
