require 'rails_helper'

feature 'Visistor access job applications' do
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
        job.apply(visitor.id)

        login_as(visitor_user, :scope => :user)
        visit root_path
        click_on 'Acompanhar candidaturas'

        expect(page).to have_content 'Você se candidatou em Vaga Legal'
        expect(page).to have_content 'Avaliação Pendente'
    end

    scenario 'and only visitors can see job applications' do
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
        job.apply(visitor.id)

        login_as(collaborator, :scope => :user)
        visit root_path

        expect(page).not_to have_content('Acompanhar candidaturas')
    end

    scenario 'and can view if company accept job applications' do
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
        job.apply(visitor.id)
        JobApplication.last.accept_application(observation: 'Gostamos do seu perfil',
                                                salary: '3000',
                                                initial_date: '01/03/2021')

        login_as(visitor_user, :scope => :user)
        visit root_path
        click_on 'Acompanhar candidaturas'

        expect(page).to have_content('Você se candidatou em Vaga Legal')
        expect(page).to have_content('Avaliação Aceita')
        expect(page).to have_content('Gostamos do seu perfil')
        expect(page).to have_content('3000')
        expect(page).to have_content('01/03/2021')
        expect(page).to have_content('Confirmar')
        expect(page).to have_content('Negar')
    end

    scenario 'and can view if company deny job applications' do
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
        job.apply(visitor.id)
        JobApplication.last.deny_application(observation: 'Gostamos do seu perfil porém procuramos outras habilidades')

        login_as(visitor_user, :scope => :user)
        visit root_path
        click_on 'Acompanhar candidaturas'

        expect(page).to have_content('Você se candidatou em Vaga Legal')
        expect(page).to have_content('Avaliação Negada')
        expect(page).to have_content('Gostamos do seu perfil porém procuramos outras habilidades')

    end

    scenario 'and show a message if no job applications' do
        visitor_user = User.create!(email: 'maria@gmail.com.br', password: '123457')
        visitor = Visitor.create!(name: 'Maria',
                                cpf: '12345678901',
                                phone: '11912345678',
                                bio: 'Lorem ipsum dolor sit amet',
                                github: 'mariaz',
                                user: visitor_user)

        login_as(visitor_user, :scope => :user)
        visit root_path
        click_on 'Acompanhar candidaturas'

        expect(page).to have_content('Não há candidaturas ainda')
    end

    scenario 'and can accept job application' do
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
        job.apply(visitor.id)
        JobApplication.last.accept_application(observation: 'Gostamos do seu perfil',
                                                salary: '3000',
                                                initial_date: '01/03/2021')

        login_as(visitor_user, :scope => :user)
        visit root_path
        click_on 'Acompanhar candidaturas'
        select('Sim', from: 'Aceita a data de inicio?')
        click_on 'Confirmar'

        expect(page).to have_content('Parabéns!')
    end

    scenario 'and can deny job application' do
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
        job.apply(visitor.id)
        JobApplication.last.accept_application(observation: 'Gostamos do seu perfil',
                                                salary: '3000',
                                                initial_date: '01/03/2021')

        login_as(visitor_user, :scope => :user)
        visit root_path
        click_on 'Acompanhar candidaturas'
        select('Não', from: 'Aceita a data de inicio?')
        fill_in 'Observação', with: 'Achei outra vaga antes desta'
        click_on 'Negar'

        expect(page).to have_content('Uma pena! Mas há outras vagas te esperando')
    end
end