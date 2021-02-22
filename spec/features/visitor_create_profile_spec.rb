require 'rails_helper'

feature 'Visitor create profile'do
    scenario 'succsefully' do
        user = User.create!(email: 'filipe@gmail.com', password: '123456')
        login_as(user, :scope => :user)

        visit new_visitor_path
        fill_in 'Nome', with: 'Filipe'
        fill_in 'CPF', with: '12345678901'
        fill_in 'Celular', with: '11912345678'
        fill_in 'Biografia', with: 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Morbi fringilla eros id molestie pharetra. Suspendisse porttitor vel libero in volutpat.'
        fill_in 'Github', with: 'tiofih'
        click_on 'Finalizar Cadastro'

        expect(current_path).to eq visitor_path(Visitor.last)
        expect(page).to have_content('Filipe')
        expect(page).to have_content('12345678901')
        expect(page).to have_content('Lorem ipsum dolor sit amet, consectetur adipiscing elit. Morbi fringilla eros id molestie pharetra. Suspendisse porttitor vel libero in volutpat.')
        expect(page).to have_content('tiofih')
        expect(page).to have_link('Voltar')
    end
end