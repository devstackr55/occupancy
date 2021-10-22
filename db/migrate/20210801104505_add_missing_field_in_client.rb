class AddMissingFieldInClient < ActiveRecord::Migration[6.1]
  def change
    add_column(:clients, :address, :string)
    add_column(:clients, :email, :string)
  end
end
