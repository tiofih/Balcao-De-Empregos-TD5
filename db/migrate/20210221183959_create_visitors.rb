class CreateVisitors < ActiveRecord::Migration[6.1]
  def change
    create_table :visitors do |t|
      t.string :name
      t.integer :cpf
      t.integer :phone
      t.text :bio
      t.string :github
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
