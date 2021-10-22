class CorrectDesignationColumn < ActiveRecord::Migration[6.1]
  def change
    rename_column :employees, :desigation, :designation
  end
end
