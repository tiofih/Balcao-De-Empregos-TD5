class AddRequirementsToJob < ActiveRecord::Migration[6.1]
  def change
    add_column :jobs, :requirements, :string
  end
end
