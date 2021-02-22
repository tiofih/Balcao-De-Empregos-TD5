class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_many :collaborators
  has_many :visitor
  after_save :include_in_collaborators

  private
  def include_in_collaborators
    if User.all.empty? or Company.all.empty? or Collaborator.all.empty?
      return
    else
      first_search = Collaborator.find_by(user_id: self.id)
      if first_search == nil
        email_domain = self.email.gsub(/.+@([^.]+).+/, '\1')
        company_id = Company.where("replace(company_name, ' ', '') like ?", "%#{email_domain}%").first.id
        Collaborator.create!(company_id: company_id, user_id: self.id)
      end
    end
  end
end
