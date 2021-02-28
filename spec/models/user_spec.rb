require 'rails_helper'

describe User do
    context 'validation' do
        it 'must determine if can be collaborator' do
            user = User.create!(email: 'filipe@campuscode.com.br', password: '123456')
            
            expect(user.can_be_collaborator?).to eq true
            expect(user.can_be_visitor?).to eq false
        end

        it 'must determine if can be visitor' do
            user = User.create!(email: 'filipe@gmail.com.br', password: '123456')
            
            expect(user.can_be_collaborator?).to eq false
            expect(user.can_be_visitor?).to eq true
        end

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
