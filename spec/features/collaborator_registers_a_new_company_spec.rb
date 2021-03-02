require 'rails_helper'

feature 'Collaborator registers a new company' do
    scenario 'succesfully' do
        user = User.create!(email: 'filipe@campuscode.com.br', password: '123456')
        login_as(user, :scope => :user)

        visit new_company_path
        fill_in 'Nome da empresa', with: 'Campus Code'
        find('form input[type="file"]').set(Rails.root.join('spec', 'support', 'logo_da_campus.jpg'))
        fill_in 'Rua', with: 'Rua vinte e seis'
        fill_in 'Número', with: '252'
        fill_in 'Bairro', with: 'Vila Olimpia'
        fill_in 'Cidade', with: 'São Paulo'
        fill_in 'CNPJ', with: '42.318.949/0001-84'
        fill_in 'Site', with: 'www.campuscode.com.br'
        fill_in 'Instagram', with: '@campuscode'
        fill_in 'Twitter', with: '@campuscode'
        fill_in 'Descrição da empresa', with: 'Realizadora de sonhos'
        click_on 'Cadastrar empresa'

        expect(current_path).to eq company_path(Company.last)
        expect(Company.last.user_id).to eq user.id
        expect(page).to have_content('Campus Code')
        expect(page).to have_css('img[src*="logo_da_campus.jpg"]')
        expect(page).to have_content('Rua vinte e seis, 252, Vila Olimpia, São Paulo')
        expect(page).to have_content('42.318.949/0001-84')
        expect(page).to have_content('www.campuscode.com.br')
        expect(page).to have_content('@campuscode')
        expect(page).to have_content('@campuscode')
        expect(page).to have_content('Realizadora de sonhos')
    end

    scenario 'and attributes cannot be blanck' do
        user = User.create!(email: 'filipe@campuscode.com.br', password: '123456')
        login_as(user, :scope => :user)

        visit new_company_path
        fill_in 'Nome da empresa', with: ''
        find('form input[type="file"]').set(Rails.root.join('spec', 'support', 'logo_da_campus.jpg'))
        fill_in 'Rua', with: ''
        fill_in 'Número', with: ''
        fill_in 'Bairro', with: ''
        fill_in 'Cidade', with: ''
        fill_in 'CNPJ', with: ''
        fill_in 'Site', with: ''
        fill_in 'Instagram', with: ''
        fill_in 'Twitter', with: ''
        fill_in 'Descrição da empresa', with: ''
        click_on 'Cadastrar empresa'

        expect(page).to have_content('Não foi possível cadastrar a empresa, veja erros abaixo:')
        expect(page).to have_content('Nome da empresa não pode ficar em branco')
        expect(page).to have_content('Rua não pode ficar em branco')
        expect(page).to have_content('Número não pode ficar em branco')
        expect(page).to have_content('Bairro não pode ficar em branco')
        expect(page).to have_content('Cidade não pode ficar em branco')
        expect(page).to have_content('CNPJ não pode ficar em branco')
        expect(page).to have_content('Site não pode ficar em branco')
    end

    scenario 'and cannot duplicate data between two companies' do
        user = User.create!(email: 'filipe@campuscode.com.br', password: '123456')
        login_as(user, :scope => :user)
        registered_company = Company.create!(company_name: 'Campus Code',
                                            street_name: 'Rua vinte e seis',
                                            street_number: '252',
                                            district: 'Vila Olimpia',
                                            city: 'São Paulo',
                                            cnpj: '42.318.949/0001-84',
                                            company_site: 'www.campuscode.com.br',
                                            user_id: user.id)

        visit new_company_path
        fill_in 'Nome da empresa', with: 'Campus Code'
        find('form input[type="file"]').set(Rails.root.join('spec', 'support', 'logo_da_campus.jpg'))
        fill_in 'Rua', with: 'Rua vinte e seis'
        fill_in 'Número', with: '252'
        fill_in 'Bairro', with: 'Vila Olimpia'
        fill_in 'Cidade', with: 'São Paulo'
        fill_in 'CNPJ', with: '42.318.949/0001-84'
        fill_in 'Site', with: 'www.campuscode.com.br'
        fill_in 'Instagram', with: '@campuscode'
        fill_in 'Twitter', with: '@campuscode'
        fill_in 'Descrição da empresa', with: 'Realizadora de sonhos'
        click_on 'Cadastrar empresa'

        expect(page).to have_content('Nome da empresa já está em uso')
        expect(page).to have_content('CNPJ já está em uso')
    end
end