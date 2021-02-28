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

    xscenario 'and can accept a job application' do
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

        expect(page).to have_content('Você aceitou a candidatura')
    end

    xscenario 'and can deny a job application' do

    end

    xscenario 'and a message is show if there are no job applications' do

    end

    xscenario 'and just collaborators can see job applications' do

    end
end