require 'rails_helper'

feature 'Visitor see job in front page' do
    scenario 'succesfully' do
        user = User.create!(email: 'filipe@campuscode.com.br', password: '123456')
        company = Company.create!(company_name: 'Campus Code',
                                            street_name: 'Rua vinte e seis',
                                            street_number: '252',
                                            district: 'Vila Olimpia',
                                            city: 'São Paulo',
                                            cnpj: '42.318.949/0001-84',
                                            company_site: 'www.campuscode.com.br',
                                            user_id: user.id)
        Job.create!(title: 'Vaga Legal',
                    description: 'Uma vaga muito legal mesmo',
                    salary_range: '2500', level: 'Júnior',
                    requirements: 'Ruby',
                    deadline: '22/04/2021', total_vacancies: '5',
                    company_id: company.id)

        visit root_path

        expect(page).to have_link('Vaga Legal')
        expect(page).to have_content('Uma vaga muito legal mesmo')
    end

    scenario 'and have a message if no jobs is registered' do
        visit root_path

        expect(page).to have_content('Não há vagas cadastradas :/')
    end

    scenario 'and clicking on job leads to description page' do
        user = User.create!(email: 'filipe@campuscode.com.br', password: '123456')
        company = Company.create!(company_name: 'Campus Code',
                                            street_name: 'Rua vinte e seis',
                                            street_number: '252',
                                            district: 'Vila Olimpia',
                                            city: 'São Paulo',
                                            cnpj: '42.318.949/0001-84',
                                            company_site: 'www.campuscode.com.br',
                                            user_id: user.id)
        clicked_job = Job.create!(title: 'Vaga Legal', 
                    description: 'Uma vaga muito legal mesmo',
                    salary_range: '2500', level: 'Júnior',
                    requirements: 'Ruby',
                    deadline: '22/12/2022', total_vacancies: '5',
                    company_id: company.id)

        unclicked_job = Job.create!(title: 'Outra Vaga Legal',
                    description: 'Outra vaga muito legal mesmo',
                    salary_range: '2500', level: 'Júnior',
                    requirements: 'Ruby',
                    deadline: '22/04/2021', total_vacancies: '5',
                    company_id: company.id)

        visit root_path
        click_on 'Vaga Legal'

        expect(current_path).to eq job_path(clicked_job)
        expect(page).to have_content('Vaga Legal')
        expect(page).to have_content('Uma vaga muito legal mesmo')
        expect(page).to have_content('2500')
        expect(page).to have_content('Júnior')
        expect(page).to have_content('Ruby')
        expect(page).to have_content('22/12/2022')
        expect(page).to have_content('5')
        expect(page).to have_link('Voltar')
    end
end