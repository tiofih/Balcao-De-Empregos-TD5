class JobApplication < ApplicationRecord
  belongs_to :job
  belongs_to :visitor

  enum status: { pending: 0, accepted: 5, denied: 10, vanquished: 15 }
  enum visitor_status: { visitor_pending: 0, visitor_accepted: 5, visitor_denied: 10 }

  def accept_application(observation:text, salary:decimal, initial_date:date)
    self.update!(:observation => observation,
                  :initial_date => initial_date,
                  :salary => salary)
    self.accepted!
  end

  def visitor_accept_application
    self.visitor_accepted!
  end

  def deny_application(observation:text)
    self.update!(:observation => observation)
    self.denied!
  end

  def visitor_deny_application(observation:text)
    self.update!(:visitor_observation => observation)
    self.denied!
  end
end
