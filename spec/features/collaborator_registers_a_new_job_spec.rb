require 'rails_helper'

feature 'Collaborator registers a new job' do
    scenario 'acces page succesfully' do
        visit root_path
        click_on 'Cadastrar nova vaga'

        expect(current_path).to eq new_job_path
    end

    scenario 'succesfully' do
        collaborator = User.create!(email: 'filipe@campuscode.com.br', password: '123456')
        company = Company.create!(company_name: 'Campus Code',
                                            street_name: 'Rua vinte e seis',
                                            street_number: '252',
                                            district: 'Vila Olimpia',
                                            city: 'São Paulo',
                                            cnpj: '42.318.949/0001-84',
                                            company_site: 'www.campuscode.com.br',
                                            user_id: collaborator.id)
        login_as(collaborator, :scope => :user)

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
        collaborator = User.create!(email: 'filipe@campuscode.com.br', password: '123456')
        company = Company.create!(company_name: 'Campus Code',
                                            street_name: 'Rua vinte e seis',
                                            street_number: '252',
                                            district: 'Vila Olimpia',
                                            city: 'São Paulo',
                                            cnpj: '42.318.949/0001-84',
                                            company_site: 'www.campuscode.com.br',
                                            user_id: collaborator.id)
        login_as(collaborator, :scope => :user)
                    
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

        expect(page).to have_content('Alguns campos não podem ficar em branco, veja abaixo:')
        expect(page).to have_content('Título não pode ficar em branco')
        expect(page).to have_content('Descrição não pode ficar em branco')
        expect(page).to have_content('Faixa Salarial não pode ficar em branco')
        expect(page).to have_content('Nível não pode ficar em branco')
        expect(page).to have_content('Requisítos não pode ficar em branco')
        expect(page).to have_content('Total de Vagas não pode ficar em branco')
    end

    scenario 'and deadline cannot be in the past' do
        collaborator = User.create!(email: 'filipe@campuscode.com.br', password: '123456')
        company = Company.create!(company_name: 'Campus Code',
                                            street_name: 'Rua vinte e seis',
                                            street_number: '252',
                                            district: 'Vila Olimpia',
                                            city: 'São Paulo',
                                            cnpj: '42.318.949/0001-84',
                                            company_site: 'www.campuscode.com.br',
                                            user_id: collaborator.id)
        login_as(collaborator, :scope => :user)

        visit new_job_path
        fill_in 'Título', with: 'Vaga Legal'
        fill_in 'Descrição', with: 'Uma vaga muito legal para pessoas bacanas numa empresa incrível'
        fill_in 'Faixa Salarial', with: '2500'
        #TODO: Mudar para select
        fill_in 'Nível', with: 'Júnior'
        #TODO: Mudar para CheckBox
        fill_in 'Requisítos', with: 'Ruby On Rails'
        fill_in 'Data Limite', with: '22/02/2021'
        fill_in 'Total de Vagas', with: '10'
        click_on 'Cadastrar vaga'

        expect(page).to have_content('Data Limite não pode ser no passado')
    end

    scenario 'and salary range cannot be less then 1' do
        collaborator = User.create!(email: 'filipe@campuscode.com.br', password: '123456')
        company = Company.create!(company_name: 'Campus Code',
                                            street_name: 'Rua vinte e seis',
                                            street_number: '252',
                                            district: 'Vila Olimpia',
                                            city: 'São Paulo',
                                            cnpj: '42.318.949/0001-84',
                                            company_site: 'www.campuscode.com.br',
                                            user_id: collaborator.id)
        login_as(collaborator, :scope => :user)

        visit new_job_path
        fill_in 'Título', with: 'Vaga Legal'
        fill_in 'Descrição', with: 'Uma vaga muito legal para pessoas bacanas numa empresa incrível'
        fill_in 'Faixa Salarial', with: '-1'
        #TODO: Mudar para select
        fill_in 'Nível', with: 'Júnior'
        #TODO: Mudar para CheckBox
        fill_in 'Requisítos', with: 'Ruby On Rails'
        fill_in 'Data Limite', with: '22/12/2022'
        fill_in 'Total de Vagas', with: '10'
        click_on 'Cadastrar vaga'

        expect(page).to have_content('Faixa Salarial não pode ser menor que 1')
    end

    scenario 'and total vacancies cannot be less then 1' do
        collaborator = User.create!(email: 'filipe@campuscode.com.br', password: '123456')
        company = Company.create!(company_name: 'Campus Code',
                                            street_name: 'Rua vinte e seis',
                                            street_number: '252',
                                            district: 'Vila Olimpia',
                                            city: 'São Paulo',
                                            cnpj: '42.318.949/0001-84',
                                            company_site: 'www.campuscode.com.br',
                                            user_id: collaborator.id)
        login_as(collaborator, :scope => :user)
        
        visit new_job_path
        fill_in 'Título', with: 'Vaga Legal'
        fill_in 'Descrição', with: 'Uma vaga muito legal para pessoas bacanas numa empresa incrível'
        fill_in 'Faixa Salarial', with: '2500'
        #TODO: Mudar para select
        fill_in 'Nível', with: 'Júnior'
        #TODO: Mudar para CheckBox
        fill_in 'Requisítos', with: 'Ruby On Rails'
        fill_in 'Data Limite', with: '22/12/2022'
        fill_in 'Total de Vagas', with: '0'
        click_on 'Cadastrar vaga'

        expect(page).to have_content('Total de Vagas não pode ser menor que 1')
    end
end