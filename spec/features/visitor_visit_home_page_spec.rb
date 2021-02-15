require 'rails_helper'

feature 'Visitor visit home page' do
    scenario 'succesfully' do
        visit root_path

        expect(page).to have_content('Balcão de Empregos')
        expect(page).to have_content('Boas vindas ao balcão de empregos!')
    end
end