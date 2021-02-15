require 'rails_helper'

feature 'Collaborator sign up' do
    context 'Without company successfully' do
        visit root_path
        click_on 'Criar login'

        fill_in 'Email', with: 'filipe@gmail.com'
        fill_in 'Senha', with: '123456'
        fill_in 'Confirme sua senha', with: '123456'
        click_on 'Criar login'

        expect(page).to have_content 'Conta criada com sucesso!'
        expect(current_path).to eq root_path
    end

    context 'With company successfully' do
        visit root_path
        click_on 'Criar login'

        fill_in 'Email', with: 'filipe@campuscode.com.br'
        fill_in 'Senha', with: '123456'
        fill_in 'Confirme sua senha', with: '123456'
        click_on 'Criar login'

        expect(page).to have_content 'Conta criada com sucesso!'
        expect(current_path).to eq new_company_path
    end

    context 'cannot leave blanck fields' do
        visit root_path
        click_on 'Criar login'

        fill_in 'Email', with: ''
        fill_in 'Senha', with: ''
        fill_in 'Confirme sua senha', with: ''
        click_on 'Criar login'

        expect(page).to have_content 'Email não pode ficar em branco'
        expect(page).to have_content 'Senha não pode ficar em branco'
        expect(page).to have_content 'Senhas não coincidem'
    end

    context 'Password must be the same' do
        visit root_path
        click_on 'Criar login'

        fill_in 'Email', with: 'filipe@campuscode.com.br'
        fill_in 'Senha', with: '123456'
        fill_in 'Confirme sua senha', with: '123457'
        click_on 'Criar login'

        expect(page).to have_content 'Senhas não coincidem'
    end
end