class CreateClients < ActiveRecord::Migration[6.1]
  def change
    create_table :clients do |t|
      t.string :title, null: false
      t.string :description
      t.string :contact_person, null: false
      t.string :contacts
      t.timestamps
    end
  end
end
