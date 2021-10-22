class CreateEmployees < ActiveRecord::Migration[6.1]
  def change
    create_table :employees do |t|
      t.string :name, null: false
      t.integer :role #team lead, Tech lead, SSE etc
      t.integer :experience #1+, 2+, 3+ etc
      t.string :email
      t.string :phone
      t.timestamps
    end
  end
end
