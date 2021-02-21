require 'rails_helper'

feature 'Visitor see job in front page' do
    scenario 'succesfully' do
        Job.create!(title: 'Vaga Legal',
                    description: 'Uma vaga muito legal mesmo',
                    salary_range: '2500', level: 'Júnior',
                    requirements: 'Ruby',
                    deadline: '22/04/2021', total_vacancies: '5')

        visit root_path

        expect(page).to have_link('Vaga Legal')
        expect(page).to have_content('Uma vaga muito legal mesmo')
    end

    scenario 'and have a message if no jobs is registered' do
        visit root_path

        expect(page).to have_content('Não há vagas cadastradas :/')
    end

    scenario 'and clicking on job leads to description page' do
        clicked_job = Job.create!(title: 'Vaga Legal', 
                    description: 'Uma vaga muito legal mesmo',
                    salary_range: '2500', level: 'Júnior',
                    requirements: 'Ruby',
                    deadline: '22/12/2022', total_vacancies: '5')

        unclicked_job = Job.create!(title: 'Outra Vaga Legal',
                    description: 'Outra vaga muito legal mesmo',
                    salary_range: '2500', level: 'Júnior',
                    requirements: 'Ruby',
                    deadline: '22/04/2021', total_vacancies: '5')

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