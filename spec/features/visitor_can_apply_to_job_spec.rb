require 'rails_helper'

feature 'Visitor can apply to job' do
    scenario 'succesfully' do
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
                    deadline: '22/12/2022', total_vacancies: '5')
        
        visit root_path
        click_on 'Vaga Legal'
        click_on 'Candidatar-se'

        expect(current_path).to eq job_path(job)
        expect(page).to have_content('Parabéns, você está concorrendo a vaga!')
    end

    scenario 'but leads to signup page if not registered yet' do
        job = Job.create!(title: 'Vaga Legal', 
                    description: 'Uma vaga muito legal mesmo',
                    salary_range: '2500', level: 'Júnior',
                    requirements: 'Ruby',
                    deadline: '22/12/2022', total_vacancies: '5')

        visit root_path
        click_on 'Vaga Legal'
        click_on 'Candidatar-se'
        
        expect(current_path).to eq new_user_session_path
        expect(page).to have_content('Você deve se cadastrar para se candidatar a vagas')
    end

    scenario 'and dont show button if already applied' do
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
                    deadline: '22/12/2022', total_vacancies: '5')
        
        visit root_path
        click_on 'Vaga Legal'
        click_on 'Candidatar-se'
        
        expect(current_path).to eq job_path(job)
        expect(page).not_to have_link('Candidatar-se')
    end
end