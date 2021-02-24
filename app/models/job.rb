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

    def apply(job_id, visitor_id)
        if already_applied?(job_id, visitor_id)
            return false
        else
            JobVisitor.create!(job_id: job_id, visitor_id: visitor_id)
        end
    end

    def already_applied?(job_id, visitor_id)
        JobVisitor.find_by(job_id: job_id) and JobVisitor.find_by(visitor_id: visitor_id)
    end
end
