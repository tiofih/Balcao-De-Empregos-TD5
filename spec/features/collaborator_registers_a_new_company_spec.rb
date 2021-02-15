require 'rails_helper'

feature 'Collaborator registers a new company' do
    scenario 'succesfully' do
        user = User.create!(login: 'filipe@campuscode.com.br', password: '123456')
        login_as(user, scope: :user)

        visit new_company_path
        fill_in 'Nome da empresa', with: 'Campus Code'
        #TODO: Alterar Parametros
        attach_file 'Logo da Campus', Rails.root.join('spec', 'support', 'logo_da_campus.jpg')
        fill_in 'Endereço', with: 'Rua vinte e seis, 252'
        fill_in 'CNPJ', with: '42.318.949/0001-84'
        fill_in 'Site', with: 'www.campuscode.com.br'
        fill_in 'Instagram', with: '@campuscode'
        fill_in 'Twitter', with: '@campuscode'
        fill_in 'Descrição da empresa', with: 'Realizadora de sonhos'
        click_on 'Cadastrar empresa'

        expect(current_path).to eq company_path(Company.last)
        expect(page).to have_content('Campus Code')
        expect(page).to have_css('img[src*="logo_da_campus.jpg"]')
        expect(page).to have_content('Rua vinte e seis, 252')
        expect(page).to have_content('42.318.949/0001-84')
        expect(page).to have_content('www.campuscode.com.br')
        expect(page).to have_content('@campuscode')
        expect(page).to have_content('@campuscode')
        expect(page).to have_content('Realizadora de sonhos')
        
    end
end