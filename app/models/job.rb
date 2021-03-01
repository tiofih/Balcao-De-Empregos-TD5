class Job < ApplicationRecord
    has_many :job_visitors
    has_many :visitors, through: :job_visitors
    belongs_to :company
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
        if !deadline_expired?
            if already_applied?(visitor_id)
                return false
            else
                JobApplication.create!(job_id: self.id, visitor_id: visitor_id)
            end
        end
    end

    def already_applied?(visitor_id)
        JobApplication.find_by(job_id: self.id) and JobApplication.find_by(visitor_id: visitor_id)
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

    def all_vacancies_filled?
        accepted_vacancies = JobApplication.where('job_id like ?', self.id)
        accepted_vacancies.count == self.total_vacancies
    end

    def deadline_expired?
        self.deadline <= Date.current
    end
end
