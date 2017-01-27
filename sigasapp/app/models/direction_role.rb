class DirectionRole < ApplicationRecord
  belongs_to :associate
  
  validates_presence_of :role, :biennium
end
