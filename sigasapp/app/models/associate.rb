class Associate < ApplicationRecord
  has_attached_file :photo, :default_url => '/assets/default-user-avatar.png'
  belongs_to :category
  has_many :direction_roles
  has_many :associate_charge
  
  before_validation :generate_associate_registration
  
  NAME_MIN_LENGTH = 5
  NAME_REGEX = /\A[^[:cntrl:]\\<>\/&]*\z/
  EMAIL_REGEX = /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i
  
  validates_presence_of :name, :gender, :birthdate, :cpf, :rg, :address, :district, :cep, :phone, :category, :city
  
  validates_format_of :name, with: NAME_REGEX
  validates_format_of :email, with: EMAIL_REGEX
  validates_length_of :name, minimum: NAME_MIN_LENGTH
  
  validates_attachment :photo, content_type: { content_type: ["image/jpeg", "image/gif", "image/png"] }
  
  def email=(arg)
    write_attribute(:email, arg.to_s.strip.downcase)
  end
  
  def category=(arg)
    write_attribute(:category_id, arg)
  end
  
  def gender_description
    self.gender
    if self.gender == "M"
      "Masculino"
    elsif self.gender == "F"
      "Feminino"
    else
      "Outro"
    end
  end
  
  private
    def generate_associate_registration
      if self.new_record?
        self.registration = 111
      end
    end
  
end
