class Visitor < ApplicationRecord
  belongs_to :user
  has_many :job_visitors
  has_many :jobs, through: :job_visitors
end
