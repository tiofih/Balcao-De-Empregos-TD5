class AddVisitorStatusAndVisitorObservationToJobApplication < ActiveRecord::Migration[6.1]
  def change
    add_column :job_applications, :visitor_status, :integer, default: 0, null: false
    add_column :job_applications, :visitor_observation, :text
  end
end
