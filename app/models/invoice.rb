class Invoice < ApplicationRecord
  enum status: %w(Pending Paid)
  belongs_to :project
  has_many :timesheets
  validates :start_date, :end_date, presence: true
  validates :start_date, :end_date, uniqueness: {:scope => :project_id}

  validates :payment_reference, :sales_remark, :paid_amount, :paid_at, presence: true, on: :update
  validates :paid_amount, numericality: { greater_than: 0 }, on: :update

  # Scopes
  scope :paid, -> { where(status: 1) }
  scope :unpaid, -> { where(status: 2) }

  after_commit :update_timesheets, on: [:create]
  after_destroy :revert_timesheets

  def paid?
    !paid_at.nil?
  end

  def invoice_id
    project_name = project.name.upcase.gsub(" ", "")
    "#{project_name}-INV-#{id}"
  end

  # project timesheet for the applied date ranges
  def project_timesheets
    project.timesheets.where(invoice_raised: false).where("on_date <= ? AND on_Date >= ?", end_date, start_date )
  end

  def raised_timesheets
    project.timesheets.where(invoice_raised: true).where("on_date <= ? AND on_Date >= ?", end_date, start_date )
  end

  private



  # Update the timesheets records in th given date range
  # Update invoice_id and invoice_raised
  def update_timesheets
    # total_hours = project_timesheets.pluck(:working_hours).sum
    # total_amount = project.hourly_charge * total_hours
    update(total_amount: total_amount, total_hours: total_hours)
    project_timesheets.update_all(invoice_id: id, invoice_raised: true)
  end

  # mark invoice_id nil and invoice_raised false
  def revert_timesheets
    projects = project.timesheets.where(invoice_raised: true).where("on_date <= ? AND on_Date >= ?", end_date, start_date )
    projects.update_all(invoice_id: nil, invoice_raised: false)
  end
end
