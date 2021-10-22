class CreateProjects < ActiveRecord::Migration[6.1]
  def change
    create_table :projects do |t|
      t.string :name, null: false
      # prefered colum is type however type is a reserved
      t.integer :category, null: false, default: 0 #iGaming, agency and individual
      # t.integer :category, null: false, default: 0 #iGaming, Non I gaming
      t.belongs_to :client, foreign_key: true
      # t.string :co_ordinator, null: false
      t.datetime :start_at, null: false
      t.datetime :expected_end_date

      t.string :profile_name
      t.integer :payment_cycle, null: false
      t.float :working_hours_per_week, null: false
      t.decimal :hourly_charge, :decimal, precision: 8, scale: 2
      t.string :skills_required
      # active, ended, terminated by client, terminated by host
      t.integer :status
      t.string :end_reason

      t.timestamps
    end
  end
end
