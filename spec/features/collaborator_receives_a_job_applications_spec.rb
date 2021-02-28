require 'rails_helper'

feature 'Collaborator receives a job application' do
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
        
        login_as(collaborator, :scope => :user)
        
        visit root_path
        click_on 'Visualizar candidaturas'

        expect(current_path).to eq search_job_application_path
        expect(page).to have_content("Maria se inscreveu em Vaga Legal")
    end

    scenario 'and can accept a job application' do
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
        click_on 'Visualizar candidaturas'
        within("div#job_application-#{JobApplication.last.id}") do
            click_on 'Aceitar candidatura'
        end

        expect(current_path).to eq search_job_application_path
        within("div#job_application-#{JobApplication.last.id}") do
            expect(page).to have_content('Você aceitou a candidatura')
            expect(page).not_to have_content('Aceitar candidatura')
        end
    end

    scenario 'and can deny a job application' do
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
        click_on 'Visualizar candidaturas'
        within("div#job_application-#{JobApplication.last.id}") do
            click_on 'Negar candidatura'
        end

        expect(current_path).to eq search_job_application_path
        within("div#job_application-#{JobApplication.last.id}") do
            expect(page).to have_content('Você negou a candidatura')
            expect(page).not_to have_content('Negar candidatura')
        end
    end

    scenario 'and a message is show if there are no job applications' do
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
        visit root_path
        click_on 'Visualizar candidaturas'

        expect(page).to have_content('Não há candidaturas')        
    end

    scenario 'and just collaborators can see job applications' do
        visitor_user = User.create!(email: 'maria@gmail.com.br', password: '123457')
        visitor = Visitor.create!(name: 'Maria',
                                cpf: '12345678901',
                                phone: '11912345678',
                                bio: 'Lorem ipsum dolor sit amet',
                                github: 'mariaz',
                                user: visitor_user)

        login_as(visitor_user, :scope => :user)

        visit root_path

        expect(page).not_to have_content('Visualizar candidaturas')
    end

    scenario 'and just same company collaborators can see job applications' do
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
        another_collaborator = User.create!(email: 'patricia@acme.com.br', password: '123456')
        another_company = Company.create!(company_name: 'Acme',
                                            street_name: 'Rua vinte e seis',
                                            street_number: '252',
                                            district: 'Vila Olimpia',
                                            city: 'São Paulo',
                                            cnpj: '42.318.949/0001-78',
                                            company_site: 'www.campuscode.com.br',
                                            user_id: another_collaborator.id)

        login_as(another_collaborator, :scope => :user)
        visit root_path
        click_on 'Visualizar candidaturas'
        
        expect(page).not_to have_content("Maria se inscreveu em Vaga Legal")
    end
end