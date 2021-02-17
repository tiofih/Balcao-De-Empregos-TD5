require 'rails_helper'

feature 'Collaborator belong to a company' do
    scenario 'after first create login is admin' do
        user = User.create!(email: 'filipe@campuscode.com', password: '123456')
        company = Company.create!(company_name: 'Campus Code',
                                    street_name: 'Rua dois',
                                    street_number: '3',
                                    district: 'Bairro',
                                    city: 'Cidade',
                                    cnpj: '00000',
                                    company_site: 'www.campus.com')
        
        expect(company.admin).to eq current_user
        expect(company.user_admin?(current_user)).to eq true
    end

    scenario 'after second create login is not admin' do
        user = User.create!(email: 'maria@campuscode.com', password: '123456')
        company = Company.create!(company_name: 'Campus Code',
                                    street_name: 'Rua dois',
                                    street_number: '3',
                                    district: 'Bairro',
                                    city: 'Cidade',
                                    cnpj: '00000',
                                    company_site: 'www.campus.com')
        
        expect(company.admin).not_to eq current_user
        expect(company.user_admin?(current_user)).to eq false
    end
end