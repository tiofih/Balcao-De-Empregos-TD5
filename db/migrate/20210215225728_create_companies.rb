class CreateCompanies < ActiveRecord::Migration[6.1]
  def change
    create_table :companies do |t|
      t.string :company_name
      t.string :street_name
      t.integer :street_number
      t.string :district
      t.string :city
      t.string :cnpj
      t.string :company_site
      t.string :company_instagram
      t.string :company_twitter
      t.string :company_description

      t.timestamps
    end
  end
end
