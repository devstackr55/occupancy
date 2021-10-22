class AddMissingFieldInInvoice < ActiveRecord::Migration[6.1]
  def up
    rename_column(:invoices, :billable_amount, :paid_amount)
    add_column(:invoices, :status, :integer, default: 0)
    add_column(:invoices, :total_hours, :integer)
    add_column(:invoices, :paid_at, :datetime)
    remove_column(:invoices, :is_paid)
  end

  def down
    rename_column(:invoices, :paid_amount, :billable_amount)
    remove_column(:invoices, :status)
    remove_column(:invoices, :total_hours)
    remove_column(:invoices, :paid_at)
    add_column(:invoices, :is_paid, :boolean, default: false)
  end
end
