require 'rails_helper'

feature 'Jobs deactivate' do
    scenario 'if all vacancies are filled' do
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
                    deadline: '22/12/2022', total_vacancies: '1',
                    company_id: company.id)
        job.apply(visitor.id)
        JobApplication.last.accept_application(observation: 'Gostamos do seu perfil',
                                                salary: '3000',
                                                initial_date: '01/03/2021')
        JobApplication.last.visitor_accept_application

        login_as(visitor_user, :scope => :user)
        visit root_path
        click_on 'Vaga Legal'

        expect(page).not_to have_content('Candidatar-se')
        expect(page).to have_content('Todas as vagas já foram preenchidas!')
    end

    xscenario 'if past the deadline' do
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
                    deadline: '10/03/2021', total_vacancies: '1',
                    company_id: company.id)

        travel_to(Date.current + 5.day)
        login_as(visitor_user, :scope => :user)
        visit root_path
        click_on 'Vaga Legal'

        expect(page).to have_content('Esta vaga já expirou')
        expect(page).not_to have_content('Candidatar-se')
    end
end