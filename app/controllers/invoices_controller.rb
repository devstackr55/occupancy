require "csv"

class InvoicesController < ApplicationController
  before_action :authenticate_user!
  load_and_authorize_resource :project
  load_and_authorize_resource :invoice, through: :project

  # GET /invoices or /invoices.json
  def index
    @invoices = @project.invoices
  end

  def timesheets
    # TBD
    @prev_balance = 0
    @timesheets = @project.timesheets.where(invoice_raised: false).where("on_date <= ? AND on_Date >= ?", Date.parse(params[:end_date]), Date.parse(params[:start_date]) )
    @total_hours = @timesheets.pluck(:working_hours).sum
    @total_amount = @total_hours * @project.hourly_charge
    respond_to do |format|
      format.js
    end
  end

  # GET /invoices/1 or /invoices/1.json
  def show
    filename = "#{@invoice.invoice_id}-#{@invoice.start_date.strftime('%F')}-to-#{@invoice.end_date.strftime('%F')}.csv"
    respond_to do |format|
      format.html
      format.csv { send_data generate_csv(), filename: filename }
    end
  end

  # GET /invoices/new
  def new
    @invoice = @project.invoices.build
  end

  # GET /invoices/1/edit
  def edit
    @invoice = Invoice.find_by(id: params[:id])
  end

  # POST /invoices or /invoices.json
  def create
    # @invoice = Invoice.new(invoice_params)

    respond_to do |format|
      if @invoice.save
        format.html { redirect_to project_invoice_path(project_id: @project.id, id: @invoice.id), notice: "Invoice was successfully created." }
        format.json { render :show, status: :created, location: @invoice }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @invoice.errors, status: :unprocessable_entity }
      end
    end
  end

  # this used to update invoice with paid amount other related details
  def capture_payment
    allowed_params = invoice_bill_params.merge!({status: 1}) if invoice_bill_params[:paid_amount].to_i > 0
    respond_to do |format|
      if @invoice.update(allowed_params)
        format.html { redirect_to project_invoice_path(@project, @invoice), notice: "Payment details has been captured" }
        format.json { render :show, status: :ok, location: @invoice }
      else
        format.html { render :show, status: :unprocessable_entity }
        format.json { render json: @invoice.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /invoices/1 or /invoices/1.json
  def update
    respond_to do |format|
      if @invoice.update(invoice_params)
        format.html { redirect_to project_invoice_path(project_id: @project.id, id: @invoice.id), notice: "Invoice was successfully updated." }
        format.json { render :show, status: :ok, location: @invoice }
      else
        format.html { render :show, status: :unprocessable_entity }
        format.json { render json: @invoice.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /invoices/1 or /invoices/1.json
  def destroy
    @invoice.destroy
    respond_to do |format|
      format.html { redirect_to project_invoices_url, notice: "Invoice was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  def generate_csv
    # attributes = %w{on_date working_hours task_type comments references}
    attributes = {on_date: "Date", task_type: "Task", comments: "Comments", references: "References", working_hours: "Logged Hours"}
    CSV.generate(headers: true) do |csv|
      csv << attributes.values

      @invoice.raised_timesheets.each do |ts|
        csv << attributes.map{ |key, value| ts.send(key) }
      end
      csv << ["","", "", "Total = ", @invoice.raised_timesheets.pluck(:working_hours).sum()]
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_invoice
      @invoice = Invoice.find(params[:id])
    end

    def set_project
      @project = Project.find_by(id: params[:project_id])
    end

    # Only allow a list of trusted parameters through.
    def invoice_params
      params.require(:invoice).permit(:project_id, :start_date, :end_date, :total_amount, :total_hours)
    end

    def invoice_bill_params
      params.require(:invoice).permit(:project_id, :payment_reference, :sales_remark, :paid_amount, :paid_at)
    end
end
