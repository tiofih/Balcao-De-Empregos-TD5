class CreateJobVisitors < ActiveRecord::Migration[6.1]
  def change
    create_table :job_visitors do |t|
      t.references :job, null: false, foreign_key: true
      t.references :visitor, null: false, foreign_key: true

      t.timestamps
    end
  end
end
