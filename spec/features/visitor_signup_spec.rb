require 'rails_helper'

feature 'Visitor signup' do
    scenario 'successfully' do
        visit root_path
        click_on 'Criar login'

        fill_in 'E-mail', with: 'filipe@gmail.com'
        fill_in 'Senha', with: '123456'
        fill_in 'Confirme sua senha', with: '123456'
        click_on 'Criar login'

        expect(page).to have_content 'Bem vindo! Você realizou seu registro com sucesso.'
        expect(current_path).to eq new_visitor_path
    end
end