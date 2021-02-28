class Company < ApplicationRecord
    has_one_attached :logo
    has_many :jobs

    validates :company_name, :street_name, :street_number, :district, 
                :city, :cnpj, :company_site, presence: true

    validates :company_name, :cnpj, uniqueness: true

    after_save :include_in_collaborators

    private
    def include_in_collaborators
        if self.id != 1
            search = Collaborator.where(company_id: self.id)
            if search.empty?
                
                Collaborator.last.update!(:company => self)
            end
        end
    end
end
