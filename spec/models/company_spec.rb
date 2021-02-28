require 'rails_helper'

describe Company do
  context 'validation' do
    it 'attributes cannot de blanck' do
      company = Company.new

      expect(company.valid?).to eq false
    end

    it 'must include a collaborator after create a company' do
            user = User.create!(email: 'filipe@campuscode.com.br', password: '123456')
            company = Company.create!(company_name: 'Campus Code',
                                        street_name: 'Rua dois',
                                        street_number: '3',
                                        district: 'Bairro',
                                        city: 'Cidade',
                                        cnpj: '00000',
                                        company_site: 'www.campus.com',
                                        user_id: user.id)

            login_as(user, :scope => :user)
            
            expect(Collaborator.last.user_id).to eq user.id
            expect(company.user_id).to eq user.id
        end
  end
end
