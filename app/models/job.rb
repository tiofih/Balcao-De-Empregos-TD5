class Job < ApplicationRecord
    has_many :job_visitors
    has_many :visitors, through: :job_visitors
    validates :title, 
                :description, 
                :salary_range, 
                :level, 
                :requirements, 
                :deadline, 
                :total_vacancies, presence: true
    validate :deadline_cannot_be_in_the_past,
                :salary_range_cannot_be_less_then_one,
                :total_vacancies_cannot_be_less_then_one

    def apply(visitor_id)
        if already_applied?(visitor_id)
            return false
        else
            JobVisitor.create!(job_id: self.id, visitor_id: visitor_id)
        end
    end

    def already_applied?(visitor_id)
        JobVisitor.find_by(job_id: self.id) and JobVisitor.find_by(visitor_id: visitor_id)
    end

    def deadline_cannot_be_in_the_past
        if deadline.present? and deadline < Date.today
            errors.add(:deadline, 'não pode ser no passado')
        end
    end

    def salary_range_cannot_be_less_then_one
        if salary_range.present? and salary_range < 1
            errors.add(:salary_range, 'não pode ser menor que 1')
        end
    end

    def total_vacancies_cannot_be_less_then_one
        if total_vacancies.present? and total_vacancies < 1
            errors.add(:total_vacancies, 'não pode ser menor que 1')
        end
    end
end
