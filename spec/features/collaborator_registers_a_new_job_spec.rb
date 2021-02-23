require 'rails_helper'

feature 'Collaborator registers a new job' do
    scenario 'acces page succesfully' do
        visit root_path
        click_on 'Cadastrar nova vaga'

        expect(current_path).to eq new_job_path
    end

    scenario 'succesfully' do
        visit new_job_path
        fill_in 'Título', with: 'Vaga Legal'
        fill_in 'Descrição', with: 'Uma vaga muito legal para pessoas bacanas numa empresa incrível'
        fill_in 'Faixa Salarial', with: '2500'
        #TODO: Mudar para select
        fill_in 'Nível', with: 'Júnior'
        #TODO: Mudar para CheckBox
        fill_in 'Requisítos', with: 'Ruby On Rails'
        fill_in 'Data Limite', with: '22/12/2022'
        fill_in 'Total de Vagas', with: '10'
        click_on 'Cadastrar vaga'

        expect(current_path).to eq job_path(Job.last)
        expect(page).to have_content('Vaga Legal')
        expect(page).to have_content('Uma vaga muito legal para pessoas bacanas numa empresa incrível')
        expect(page).to have_content('2500')
        expect(page).to have_content('Júnior')
        expect(page).to have_content('Ruby On Rails')
        expect(page).to have_content('22/12/2022')
        expect(page).to have_content('10')
        expect(page).to have_link('Voltar')
    end

    scenario 'and attributes cannot be blanck' do
        visit new_job_path
        fill_in 'Título', with: ''
        fill_in 'Descrição', with: ''
        fill_in 'Faixa Salarial', with: ''
        #TODO: Mudar para select
        fill_in 'Nível', with: ''
        #TODO: Mudar para CheckBox
        fill_in 'Requisítos', with: ''
        fill_in 'Data Limite', with: '22/12/2022'
        fill_in 'Total de Vagas', with: ''
        click_on 'Cadastrar vaga'

        expect(page).to have_content('Alguns campos não podem ficar em branco')
    end
end