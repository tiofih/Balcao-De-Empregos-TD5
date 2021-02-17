class Company < ApplicationRecord
    has_one_attached :logo

    validates :company_name, :street_name, :street_number, :district, 
                :city, :cnpj, :company_site, :logo, presence: true
    #validates :company_name, uniquiness: true

    def self.user_admin? (email)
        email_domain = email.gsub(/.+@([^.]+).+/, '\1')
        company_search = Company.where('company_name like ?', "%#{email_domain}%")
        !company_search.any?
    end

    def self.common_user? (email)
        email_domain = email.gsub(/.+@([^.]+).+/, '\1')
        common_emails = ["gmail", "outlook", "hotmail"]
        common_emails.include?(email_domain)
    end
end
