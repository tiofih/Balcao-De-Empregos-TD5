class Job < ApplicationRecord
    validates :title, :description, :salary_range, :level, :requirements, :deadline, :total_vacancies, presence: true
end
