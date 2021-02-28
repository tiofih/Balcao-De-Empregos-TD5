class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_one :collaborator
  has_one :visitor
  after_save :include_in_collaborators

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
      company_search = Company.find_by("replace(company_name, ' ', '') like ?", "%#{email_domain}%")
      if company_search.nil?
        first_company = Company.new
        if Company.all.empty?
          first_company = Company.create!(company_name: 'First',
                          street_name: 'aaa',
                          street_number: '1',
                          district: 'aaa',
                          city: 'aa',
                          cnpj: '11.111.111/0001-11',
                          company_site: 'aa',
                          user_id: self.id)
        else
          first_company = Company.all.first
        end
        Collaborator.create!(company_id: first_company.id, user_id: self.id)
      else
        Collaborator.create!(company_id: company_search.id, user_id: self.id)
      end
    end
  end
end
