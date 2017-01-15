class Category < ApplicationRecord
  has_one :associate
  validates_presence_of :description, :value_in_cash, :value_in_installments
  
end
