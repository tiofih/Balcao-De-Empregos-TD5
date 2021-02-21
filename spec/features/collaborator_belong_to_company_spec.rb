require 'rails_helper'

feature 'Collaborator belong to a company' do
    scenario 'after first create login is admin' do
        user = User.create!(email: 'filipe@campuscode.com.br', password: '123456')
        login_as(user, :scope => :user)
        company = Company.create!(company_name: 'Campus Code',
                                    street_name: 'Rua dois',
                                    street_number: '3',
                                    district: 'Bairro',
                                    city: 'Cidade',
                                    cnpj: '00000',
                                    company_site: 'www.campus.com',
                                    user_id: user.id)

        expect(company.user_id).to eq user.id
        expect(Company.can_be_user_admin?(user.email)).to eq false
    end

    scenario 'after second create login is not admin and enters the company' do
        first_user = User.create!(email: 'filipe@campuscode.com.br', password: '123456')
        company = Company.create!(company_name: 'Campus Code',
                                    street_name: 'Rua dois',
                                    street_number: '3',
                                    district: 'Bairro',
                                    city: 'Cidade',
                                    cnpj: '00000',
                                    company_site: 'www.campus.com',
                                    user_id: first_user.id)
        second_user = User.create!(email: 'maria@campuscode.com', password: '123456')
        login_as(second_user, :scope => :user)
        
        expect(company.user_id).to eq first_user.id
        expect(company.user_id).not_to eq second_user.id
        expect(Company.can_be_user_admin?(second_user.email)).to eq false
    end
end