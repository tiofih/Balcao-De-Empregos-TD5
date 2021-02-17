require 'rails_helper'

feature 'Collaborator sign up' do
    scenario 'Without company successfully' do
        visit root_path
        click_on 'Criar login'

        fill_in 'E-mail', with: 'filipe@gmail.com'
        fill_in 'Senha', with: '123456'
        fill_in 'Confirme sua senha', with: '123456'
        click_on 'Criar login'

        expect(page).to have_content 'Bem vindo! Você realizou seu registro com sucesso.'
        expect(current_path).to eq root_path
    end

    scenario 'With company successfully' do
        visit root_path
        click_on 'Criar login'

        fill_in 'E-mail', with: 'filipe@campuscode.com.br'
        fill_in 'Senha', with: '123456'
        fill_in 'Confirme sua senha', with: '123456'
        click_on 'Criar login'

        expect(page).to have_content 'Bem vindo! Você realizou seu registro com sucesso.'
        expect(current_path).to eq new_company_path
    end

    scenario 'cannot leave blanck fields' do
        visit root_path
        click_on 'Criar login'

        fill_in 'E-mail', with: ''
        fill_in 'Senha', with: ''
        fill_in 'Confirme sua senha', with: ''
        click_on 'Criar login'

        expect(page).to have_content 'E-mail não pode ficar em branco'
        expect(page).to have_content 'Senha não pode ficar em branco'
    end

    scenario 'Password must be the same' do
        visit root_path
        click_on 'Criar login'

        fill_in 'E-mail', with: 'filipe@campuscode.com.br'
        fill_in 'Senha', with: '123456'
        fill_in 'Confirme sua senha', with: '123457'
        click_on 'Criar login'

        expect(page).to have_content 'Confirme sua senha não é igual a Senha'
    end
end