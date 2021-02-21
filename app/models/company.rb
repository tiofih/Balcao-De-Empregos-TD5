class Company < ApplicationRecord
    has_one_attached :logo

    validates :company_name, :street_name, :street_number, :district, 
                :city, :cnpj, :company_site, presence: true

    def self.can_be_user_admin? (email)
        email_domain = email.gsub(/.+@([^.]+).+/, '\1')
        company_search = Company.where("replace(company_name, ' ', '') like ?", "%#{email_domain}%")
        company_search.empty?
    end

    def self.can_be_common_user? (email)
        email_domain = email.gsub(/.+@([^.]+).+/, '\1')
        common_emails = ["gmail", "outlook", "hotmail"]
        common_emails.include?(email_domain)
    end
end
