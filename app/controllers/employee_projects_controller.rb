class EmployeeProjectsController < ApplicationController
  before_action :authenticate_user!

  load_and_authorize_resource :project
  load_and_authorize_resource :employee_project, through: :project
  #before_action :set_employee_project, only: %i[ show edit update destroy]
  # before_action :set_employee

  # GET /employee_projects or /employee_projects.json
  def index
    # @employee_projects = @project.employee_projects
  end

  # GET /employee_projects/1 or /employee_projects/1.json
  def show
  end

  # GET /employee_projects/new
  def new
    @employee_project = @project.employee_projects.build
  end

  # GET /employee_projects/1/edit
  def edit
  end

  # POST /employee_projects or /employee_projects.json
  def create
    # @employee_project = @project.employee_projects.build

    respond_to do |format|
      if @employee_project.save
        format.html { redirect_to project_employee_projects_path(@project), notice: "Employee project was successfully created." }
        format.json { render :show, status: :created, location: @employee_project }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @employee_project.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /employee_projects/1 or /employee_projects/1.json
  def update
    respond_to do |format|
      if @employee_project.update(employee_project_params)
        format.html { redirect_to project_employee_projects_path(@project), notice: "Employee project was successfully updated." }
        format.json { render :show, status: :ok, location: @employee_project }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @employee_project.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /employee_projects/1 or /employee_projects/1.json
  def destroy
    @employee_project.destroy
    respond_to do |format|
      format.html { redirect_to employee_projects_url, notice: "Employee project was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_employee_project
      @employee_project = EmployeeProject.find(params[:id])
    end

    def set_employee
      @employee = Employee.find(params[:employee_id])
    end

    # Only allow a list of trusted parameters through.
    def employee_project_params
      # params.fetch(:employee_project, {})
      params.require(:employee_project).permit(:employee_id, :project_id, :weekly_occupancy, :role, :start_at, :ended_on, :comments)
    end
end
