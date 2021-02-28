require 'rails_helper'

describe Job do
    context '#apply' do
        it 'can apply to a job' do
            collaborator = User.create!(email: 'filipe@campuscode.com', password: '123456')
            company = Company.create!(company_name: 'Campus Code',
                                        street_name: 'Rua dois',
                                        street_number: '3',
                                        district: 'Bairro',
                                        city: 'Cidade',
                                        cnpj: '00000',
                                        company_site: 'www.campus.com',
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

            job.apply(visitor.id)

            expect(JobApplication.last.job_id).to eq job.id
            expect(JobApplication.last.visitor_id).to eq visitor.id
        end

        it 'cant apply to a job twice or more' do
            collaborator = User.create!(email: 'filipe@campuscode.com', password: '123456')
            company = Company.create!(company_name: 'Campus Code',
                                        street_name: 'Rua dois',
                                        street_number: '3',
                                        district: 'Bairro',
                                        city: 'Cidade',
                                        cnpj: '00000',
                                        company_site: 'www.campus.com',
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

            job.apply(visitor.id)
            job.apply(visitor.id)

            expect(JobApplication.count).to eq 1
        end
    end
end
