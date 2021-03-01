# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

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
