class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_one :collaborator
  has_many :visitor
  after_save :include_in_collaborators

  def self.can_be_company_admin? (email)
    email_domain = email.gsub(/.+@([^.]+).+/, '\1')
    company_search = Company.where("replace(company_name, ' ', '') like ?", "%#{email_domain}%")
    company_search.empty?
  end

  def self.can_be_common_user? (email)
    email_domain = email.gsub(/.+@([^.]+).+/, '\1')
    common_emails = ["gmail", "outlook", "hotmail"]
    common_emails.include?(email_domain)
  end

  def can_be_collaborator?
    email_domain = self.email.gsub(/.+@([^.]+).+/, '\1')
    common_emails = ["gmail", "outlook", "hotmail"]
    !common_emails.include?(email_domain)
  end

  def can_be_visitor?
    email_domain = self.email.gsub(/.+@([^.]+).+/, '\1')
    common_emails = ["gmail", "outlook", "hotmail"]
    common_emails.include?(email_domain)
  end

  private
  def include_in_collaborators
    if can_be_collaborator?
      email_domain = self.email.gsub(/.+@([^.]+).+/, '\1')
      company_search = Company.where("replace(company_name, ' ', '') like ?", "%#{email_domain}%")
      if company_search.empty?
        first_company = Company.create!(company_name: 'First',
                        street_name: 'aaa',
                        street_number: '1',
                        district: 'aaa',
                        city: 'aa',
                        cnpj: '11.111.111/0001-11',
                        company_site: 'aa',
                        user_id: self.id)
        Collaborator.create!(company_id: first_company.id, user_id: self.id)
      else
        Collaborator.create!(company_id: company_search.ids.first, user_id: self.id)
      end
    end
  end
end
