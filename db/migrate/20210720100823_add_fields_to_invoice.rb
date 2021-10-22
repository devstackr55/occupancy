class AddFieldsToInvoice < ActiveRecord::Migration[6.1]
  def change
    add_column :invoices, :sales_remark, :string
    add_column :invoices, :billable_amount, :decimal
  end
end
