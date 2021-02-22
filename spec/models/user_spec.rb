require 'rails_helper'

describe User do
    context 'validation' do
        it 'must include in collaborators if enterprise email' do
            first_user = User.create!(email: 'filipe@campuscode.com.br', password: '123456')
            company = Company.create!(company_name: 'Campus Code',
                                        street_name: 'Rua dois',
                                        street_number: '3',
                                        district: 'Bairro',
                                        city: 'Cidade',
                                        cnpj: '00000',
                                        company_site: 'www.campus.com',
                                        user_id: first_user.id)
            second_user = User.create!(email: 'maria@campuscode.com.br', password: '123456')
            
            expect(Collaborator.last.user_id).to eq second_user.id
        end
    end
end
