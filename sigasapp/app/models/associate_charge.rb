class AssociateCharge < ApplicationRecord
  belongs_to :associate
  
  validates_presence_of :description, :value, :due_date
  
  def situation
    if !self.pay_date.nil?
      "Paga"
    elsif self.due_date >= Date.today
      "Pendente"
    elsif self.due_date < Date.today
      "Atrasada"
    end
  end
  
  def print_value
    "R$ " + self.value.to_s
  end
  
end
