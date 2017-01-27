class AssociateBond < ApplicationRecord
  validates_presence_of :associate_id, :bond, :dependent_id
end
