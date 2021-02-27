require 'rails_helper'

feature 'Collaborator receives a job application' do
    scenario 'succesfully' do
        collaborator = User.create!(email: 'filipe@campuscode.com.br', password: '123456')
        visitor_user = User.create!(email: 'maria@gmail.com.br', password: '123457')
        visitor = Visitor.create!(name: 'Filipe',
                                cpf: '12345678901',
                                phone: '11912345678',
                                bio: 'Lorem ipsum dolor sit amet',
                                github: 'tiofih',
                                user: visitor_user)
        job = Job.create!(title: 'Vaga Legal', 
                    description: 'Uma vaga muito legal mesmo',
                    salary_range: '2500', level: 'Júnior',
                    requirements: 'Ruby',
                    deadline: '22/12/2022', total_vacancies: '5')
        job.apply(visitor.id)

        login_as(collaborator, :scope => :user)
        visit root_path
        click_on 'Visualizar candidaturas'
    end

    xscenario 'and can accept a job application' do

    end

    xscenario 'and can deny a job application' do

    end

    xscenario 'and a message is show if there are no job applications' do

    end

    xscenario 'and just collaborators can see job applications' do

    end
end