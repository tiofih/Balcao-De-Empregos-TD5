class JobApplication < ApplicationRecord
  belongs_to :job
  belongs_to :visitor

  enum status: { pending: 0, accepted: 5, denied: 10, vanquished: 15 }
end
