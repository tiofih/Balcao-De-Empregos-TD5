class RenameJobVisitorsToJobApplications < ActiveRecord::Migration[6.1]
  def self.up
    rename_table :job_visitors, :job_applications
  end

  def self.down
    rename_table :job_applications, :job_visitors
  end
end
