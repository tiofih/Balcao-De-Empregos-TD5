class AddStatusObservationSalaryInitialDateToJobApplication < ActiveRecord::Migration[6.1]
  def change
    add_column :job_applications, :status, :integer, default: 0, null: false
    add_column :job_applications, :observation, :text
    add_column :job_applications, :initial_date, :date
    add_column :job_applications, :salary, :decimal
  end
end
