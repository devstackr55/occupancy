class EmployeesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_skill, only: [:index, :statistics]
  load_and_authorize_resource :employee, except: [:index]

  def index
    @employees = @skill.employees.where.not(email: DEFAULT_ADMIN_EMAIL)
  end

  # GET /employees or /employees.json
  def search
    query = []
    @experience = params[:experience] || 0
    @role = params[:role]
    @project = params[:project]
    @name = params[:name]
    @skill = params[:skill]
    @weekly_occupancy = params[:occupancy].blank? ? "0,100" : params[:occupancy]
    @sort = params[:sort] || "total_allocation"
    @order_by = params[:order_by] || "desc"

    weekly_occupancy = @weekly_occupancy.split(",")

    query << "employees.name ILIKE '#{@name}%'" unless params[:name].blank?
    query << "employee_projects.project_id = #{@project}" unless(params[:project].blank?)
    query << "employee_projects.role = #{@role}" unless(params[:role].blank?)

    query << "skills.id = #{@skill}" unless(params[:skill].blank?)
    # join multiple queries
    query = query.join(" and ")

    @employees = Employee.
    joins(:primary_skills).
    joins(:user).
    left_outer_joins(:employee_projects).
    group("employees.id").
    where("users.role = 'employee'").
    having("sum(employee_projects.weekly_occupancy) is null OR (sum(employee_projects.weekly_occupancy) >= #{weekly_occupancy[0]} and sum(employee_projects.weekly_occupancy) < #{weekly_occupancy[1]})").
    where(query).
    select("employees.*, sum(employee_projects.weekly_occupancy) as total_allocation, count(employee_projects.project_id) as total_projects").
    order("#{@sort} #{@order_by}")
  end

  # GET /employees/1 or /employees/1.json
  def show
  end

  # GET /employees/new
  def new
    @employee = Employee.new
  end

  # GET /employees/1/edit
  def edit
  end

  # POST /employees or /employees.json
  def create
    @employee = Employee.new(employee_params)

    respond_to do |format|
      if @employee.save
        format.html { redirect_to @employee, notice: "Employee was successfully created." }
        format.json { render :show, status: :created, location: @employee }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @employee.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /employees/1 or /employees/1.json
  def update
    respond_to do |format|
      if @employee.update(employee_params)
        format.html { redirect_to @employee, notice: "Employee was successfully updated." }
        format.json { render :show, status: :ok, location: @employee }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @employee.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /employees/1 or /employees/1.json
  def destroy
    @employee.destroy
    respond_to do |format|
      format.html { redirect_to employees_url, notice: "Employee was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  #
  def statistics
    # static counts
    @employee_count = @skill.primary_employees.count
    @employees_can_manage_client = @skill.primary_employees.where("client_management_skill > 6").count()
    @employees_can_manage_development = @skill.primary_employees.where("client_management_skill <= 6 and development_skill > 4").count()
    @fresher_developers = @skill.primary_employees.where("development_skill <= 1").count()

    # availablity count
    @available_employees = @skill.primary_employees.joins(:employee_projects).group("employees.id").having("sum(employee_projects.weekly_occupancy) <= 10").select("employees.*, sum(employee_projects.weekly_occupancy) as total_allocation, count(employee_projects.project_id) as total_projects").length
    # these are the employee who will released by this day
    @released_day = params[:date].blank? ? (Date.today + 2.months) : Date.parse(params[:date])
    employees_released = Project.joins(:employee_projects).where("expected_end_date < '#{@released_day}'").select("employee_id").pluck(:employee_id)
    @will_be_available = Employee.joins(:primary_skills, :user).where("skills.id = #{@skill.id} and users.role = 'employee'").where(employees: {id: employees_released}).count()
    @resigned_employee = @skill.primary_employees.where("last_working_day <= '#{@released_day}'").count()

    @lead_employees = @skill.primary_employees.where("client_management_skill > 6")
    @developers = @skill.primary_employees.where("client_management_skill < 6")
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_skill
      @skill = Skill.find(params[:skill_id])
    end

    # Only allow a list of trusted parameters through.
    def employee_params
      params.require(:employee).permit(:name, :email, :phone, :ctc_per_day, :designation, :last_working_day, :development_skill, :client_management_skill, :mentorship_skill, :experience, :primary_skill_id, :role)
    end

    def check_admin?
     unless current_user.admin?
       redirect_to root_path
       flash[:error] = "This operation is not permitted"
     end
    end
end
