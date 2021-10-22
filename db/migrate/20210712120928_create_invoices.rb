class CreateInvoices < ActiveRecord::Migration[6.1]
  def change
    create_table :invoices do |t|
      t.integer :project_id
      t.datetime :start_date
      t.datetime :end_date
      t.decimal :total_amount
      t.boolean :is_paid, default: false
      t.text :payment_reference

      t.timestamps
    end
  end
end
