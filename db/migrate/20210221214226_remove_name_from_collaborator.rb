class RemoveNameFromCollaborator < ActiveRecord::Migration[6.1]
  def change
    remove_column :collaborators, :name, :string
  end
end
