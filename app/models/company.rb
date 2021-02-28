class Company < ApplicationRecord
    has_one_attached :logo
    has_many :jobs

    validates :company_name, :street_name, :street_number, :district, 
                :city, :cnpj, :company_site, presence: true

    validates :company_name, :cnpj, uniqueness: true
end
