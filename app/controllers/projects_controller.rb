class ProjectsController < ApplicationController
  before_action :authenticate_user!
  load_and_authorize_resource :project , except: [:index]
  load_and_authorize_resource :employee , through: :project, only: [:member]
  #before_action :set_project, only: %i[ show edit update destroy ]

  # GET /projects or /projects.json
  def index
    @projects = Project.all.order(:start_at)
  end

  # GET /projects/1 or /projects/1.json
  def show
  end

  # GET /projects/new
  def new
    @project = Project.new
  end

  # GET /projects/1/edit
  def edit
  end

  def member
  end

  # POST /projects or /projects.json
  def create
    @project = Project.new(project_params)

    respond_to do |format|
      if @project.save
        format.html { redirect_to projects_path, notice: "Project was successfully created." }
        format.json { render :show, status: :created, location: @project }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @project.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /projects/1 or /projects/1.json
  def update
    respond_to do |format|
      if @project.update(project_params)
        format.html { redirect_to projects_path, notice: "Project was successfully updated." }
        format.json { render :show, status: :ok, location: @project }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @project.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /projects/1 or /projects/1.json
  def destroy
    @project.destroy
    respond_to do |format|
      format.html { redirect_to projects_url, notice: "Project was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  def plan
    @target_date = params[:target_date]
    @per_hour_billing = params[:per_hour_billing].to_i
    @goal_amount = params[:goal_amount].to_i
    @no_of_projects_required = 0
    # perform the calculation
    if @per_hour_billing > 0 && @goal_amount
      calculation()
    end
  end

  def calculation
    puts "===values----"
    # 10% deduction
    actual_amount = @per_hour_billing - (@per_hour_billing/10)
    actual_amount_weekly = actual_amount*40
    puts actual_amount_weekly
    # $18 x 40 (hrs a week) = 720
    @no_of_projects_required = (@goal_amount/actual_amount_weekly).ceil
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_project
      @project = Project.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def project_params
      params.require(:project).permit(:name, :category, :client_id, :start_at, :expected_end_date, :profile_name, :payment_cycle, :working_hours_per_week, :hourly_charge, :decimal, :skills_required, :status, :end_reason,)
    end
end
