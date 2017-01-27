class AssociateCharge < ApplicationRecord
  belongs_to :associate
  
  validates_presence_of :description, :value, :due_date
end
