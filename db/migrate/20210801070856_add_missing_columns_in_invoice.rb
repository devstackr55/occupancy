class AddMissingColumnsInInvoice < ActiveRecord::Migration[6.1]
  def change
    add_column(:timesheets, :invoice_raised, :boolean, default: false)
  end
end
