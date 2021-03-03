require 'rails_helper'

feature 'Collaborator can edit jobs' do
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
        job = Job.create!(title: 'Vaga Legal', 
                    description: 'Uma vaga muito legal mesmo',
                    salary_range: '2500', level: 'Júnior',
                    requirements: 'Ruby',
                    deadline: '22/12/2022', total_vacancies: '5',
                    company_id: company.id)

        login_as(collaborator, :scope => :user)
        visit root_path
        click_on 'Vaga Legal'
        click_on 'Editar Vaga'

        fill_in 'Título', with: 'Vaga Legal remaster'
        fill_in 'Descrição', with: 'Uma vaga muito legal para pessoas bacanas numa empresa incrívelmente incrível'
        fill_in 'Faixa Salarial', with: '3000'
        #TODO: Mudar para select
        fill_in 'Nível', with: 'Júnior'
        #TODO: Mudar para CheckBox
        fill_in 'Requisítos', with: 'Ruby On Rails e Python'
        fill_in 'Data Limite', with: '25/12/2022'
        fill_in 'Total de Vagas', with: '5'
        click_on 'Editar vaga'

        expect(current_path).to eq job_path(job)
        expect(page).to have_content('Vaga Legal remaster')
        expect(page).to have_content('Uma vaga muito legal para pessoas bacanas numa empresa incrívelmente incrível')
        expect(page).to have_content('3000')
        expect(page).to have_content('Júnior')
        expect(page).to have_content('Ruby On Rails e Python')
        expect(page).to have_content('25/12/2022')
        expect(page).to have_content('5')
    end

    scenario 'and cant leave blanck fields' do
        collaborator = User.create!(email: 'filipe@campuscode.com.br', password: '123456')
        company = Company.create!(company_name: 'Campus Code',
                                            street_name: 'Rua vinte e seis',
                                            street_number: '252',
                                            district: 'Vila Olimpia',
                                            city: 'São Paulo',
                                            cnpj: '42.318.949/0001-84',
                                            company_site: 'www.campuscode.com.br',
                                            user_id: collaborator.id)
        job = Job.create!(title: 'Vaga Legal', 
                    description: 'Uma vaga muito legal mesmo',
                    salary_range: '2500', level: 'Júnior',
                    requirements: 'Ruby',
                    deadline: '22/12/2022', total_vacancies: '5',
                    company_id: company.id)

        login_as(collaborator, :scope => :user)
        visit root_path
        click_on 'Vaga Legal'
        click_on 'Editar Vaga'

        fill_in 'Título', with: ''
        fill_in 'Descrição', with: ''
        fill_in 'Faixa Salarial', with: ''
        #TODO: Mudar para select
        fill_in 'Nível', with: ''
        #TODO: Mudar para CheckBox
        fill_in 'Requisítos', with: ''
        fill_in 'Data Limite', with: '25/12/2022'
        fill_in 'Total de Vagas', with: ''
        click_on 'Editar vaga'

        expect(page).to have_content('Alguns campos não podem ficar em branco, veja abaixo:')
        expect(page).to have_content('Título não pode ficar em branco')
        expect(page).to have_content('Descrição não pode ficar em branco')
        expect(page).to have_content('Faixa Salarial não pode ficar em branco')
        expect(page).to have_content('Nível não pode ficar em branco')
        expect(page).to have_content('Requisítos não pode ficar em branco')
        expect(page).to have_content('Total de Vagas não pode ficar em branco')
    end

    scenario 'and must be a collaborator to edit' do
        collaborator = User.create!(email: 'filipe@campuscode.com.br', password: '123456')
        company = Company.create!(company_name: 'Campus Code',
                                            street_name: 'Rua vinte e seis',
                                            street_number: '252',
                                            district: 'Vila Olimpia',
                                            city: 'São Paulo',
                                            cnpj: '42.318.949/0001-84',
                                            company_site: 'www.campuscode.com.br',
                                            user_id: collaborator.id)
        visitor_user = User.create!(email: 'maria@gmail.com.br', password: '123457')
        visitor = Visitor.create!(name: 'Maria',
                                cpf: '12345678901',
                                phone: '11912345678',
                                bio: 'Lorem ipsum dolor sit amet',
                                github: 'mariaz',
                                user: visitor_user)
        job = Job.create!(title: 'Vaga Legal', 
                    description: 'Uma vaga muito legal mesmo',
                    salary_range: '2500', level: 'Júnior',
                    requirements: 'Ruby',
                    deadline: '22/12/2022', total_vacancies: '5',
                    company_id: company.id)

        login_as(visitor_user, :scope => :user)
        visit root_path
        click_on 'Vaga Legal'
        
        expect(page).not_to have_content('Editar vaga')
    end
end