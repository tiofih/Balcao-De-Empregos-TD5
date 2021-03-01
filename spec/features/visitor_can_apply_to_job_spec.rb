require 'rails_helper'

feature 'Visitor can apply to job' do
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
        user = User.create!(email: 'filipe@gmail.com', password: '123456')
        login_as(user, :scope => :user)
        visitor = Visitor.create!(name: 'Filipe',
                                cpf: '12345678901',
                                phone: '11912345678',
                                bio: 'Lorem ipsum dolor sit amet',
                                github: 'tiofih',
                                user: user)
        job = Job.create!(title: 'Vaga Legal', 
                    description: 'Uma vaga muito legal mesmo',
                    salary_range: '2500', level: 'Júnior',
                    requirements: 'Ruby',
                    deadline: '22/12/2022', total_vacancies: '5',
                    company_id: company.id)
        
        visit root_path
        click_on 'Vaga Legal'
        click_on 'Candidatar-se'

        expect(current_path).to eq job_path(job)
        expect(page).to have_content('Parabéns, você está concorrendo a vaga!')
    end

    scenario 'but leads to signup page if not registered yet' do
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

        visit root_path
        click_on 'Vaga Legal'
        click_on 'Candidatar-se'
        
        expect(current_path).to eq new_user_session_path
        expect(page).to have_content('Para continuar, faça login ou registre-se')
    end

    scenario 'and dont show button if already applied' do
        collaborator = User.create!(email: 'filipe@campuscode.com.br', password: '123456')
        company = Company.create!(company_name: 'Campus Code',
                                            street_name: 'Rua vinte e seis',
                                            street_number: '252',
                                            district: 'Vila Olimpia',
                                            city: 'São Paulo',
                                            cnpj: '42.318.949/0001-84',
                                            company_site: 'www.campuscode.com.br',
                                            user_id: collaborator.id)
        user = User.create!(email: 'filipe@gmail.com', password: '123456')
        login_as(user, :scope => :user)
        visitor = Visitor.create!(name: 'Filipe',
                                cpf: '12345678901',
                                phone: '11912345678',
                                bio: 'Lorem ipsum dolor sit amet',
                                github: 'tiofih',
                                user: user)
        job = Job.create!(title: 'Vaga Legal', 
                    description: 'Uma vaga muito legal mesmo',
                    salary_range: '2500', level: 'Júnior',
                    requirements: 'Ruby',
                    deadline: '22/12/2022', total_vacancies: '5',
                    company_id: company.id)
        
        visit root_path
        click_on 'Vaga Legal'
        click_on 'Candidatar-se'
        
        expect(current_path).to eq job_path(job)
        expect(page).not_to have_link('Candidatar-se')
    end
end