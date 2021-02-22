class JobVisitor < ApplicationRecord
  belongs_to :job
  belongs_to :visitor
end
