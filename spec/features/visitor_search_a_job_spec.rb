require 'rails_helper'

feature 'Visitor search a promotion' do
    scenario 'succesfully' do
        Job.create!(title: 'Vaga Legal', 
                    description: 'Uma vaga muito legal mesmo',
                    salary_range: '2500', level: 'Júnior',
                    requirements: 'Ruby',
                    deadline: '22/12/2022', total_vacancies: '5')

        Job.create!(title: 'Outra vaga Legal',
                    description: 'Outra vaga muito legal mesmo',
                    salary_range: '2500', level: 'Júnior',
                    requirements: 'Ruby',
                    deadline: '22/04/2021', total_vacancies: '5')

        visit root_path
        fill_in 'Busca', with: 'Outra vaga legal'
        click_on 'Pesquisar'

        expect(page).to have_content('Outra vaga Legal')
        expect(page).to have_content('Outra vaga muito legal mesmo')
        expect(page).to have_content('2500')
        expect(page).to have_content('Júnior')
        expect(page).to have_content('Ruby')
        expect(page).to have_content('22/04/2021')
        expect(page).to have_content('5')
        expect(page).to have_link('Voltar')
    end

    scenario 'and return error message if no job is found' do
        visit root_path
        fill_in 'Busca', with: 'Outra vaga legal'
        click_on 'Pesquisar'

        expect(page).to have_content('Nenhuma vaga encontrada :/')
    end

    scenario 'and find more than one job' do
        Job.create!(title: 'Vaga Legal', 
                    description: 'Uma vaga muito legal mesmo',
                    salary_range: '2500', level: 'Júnior',
                    requirements: 'Ruby',
                    deadline: '22/12/2022', total_vacancies: '5')

        Job.create!(title: 'Outra vaga Legal',
                    description: 'Outra vaga muito legal mesmo',
                    salary_range: '2500', level: 'Júnior',
                    requirements: 'Ruby',
                    deadline: '22/04/2021', total_vacancies: '5')

        visit root_path
        fill_in 'Busca', with: 'vaga'
        click_on 'Pesquisar'

        expect(page).to have_content('Vaga Legal')
        expect(page).to have_content('Uma vaga muito legal mesmo')
        expect(page).to have_content('2500')
        expect(page).to have_content('Júnior')
        expect(page).to have_content('Ruby')
        expect(page).to have_content('22/12/2022')
        expect(page).to have_content('5')
        expect(page).to have_content('Outra vaga Legal')
        expect(page).to have_content('Outra vaga muito legal mesmo')
        expect(page).to have_content('2500')
        expect(page).to have_content('Júnior')
        expect(page).to have_content('Ruby')
        expect(page).to have_content('22/04/2021')
        expect(page).to have_content('5')
        expect(page).to have_link('Voltar')
    end
end