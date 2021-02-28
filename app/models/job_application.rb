class JobApplication < ApplicationRecord
  belongs_to :job
  belongs_to :visitor
end
