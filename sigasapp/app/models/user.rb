class User < ApplicationRecord
  attr_accessor :current_password, :password, :password_confirmation
  
  before_validation :check_password_for_new_record
  
  NAME_MIN_LENGTH = 5
  NAME_REGEX = /\A[^[:cntrl:]\\<>\/&]*\z/
  EMAIL_REGEX = /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i
  
  validates_presence_of :name, :email
  validates_format_of :name, with: NAME_REGEX
  validates_format_of :email, with: EMAIL_REGEX
  validates_length_of :name, minimum: NAME_MIN_LENGTH
  validates_uniqueness_of :email, case_sensitive: false
  
  def self.authenticate(email, password)
    return false if email.blank? || password.blank?
    user = where('active = ? AND email = ?', true, email).first
    user if user.is_a?(User) && user.authenticated?(password)
  end

  def authenticated?(password)
    Digest::MD5.hexdigest(password) == self.encrypted_password
  end

  def name=(arg)
    if self.new_record?
      write_attribute(:name, arg.to_s)
    else
      super
    end
  end

  def email=(arg)
    write_attribute(:email, arg.to_s.strip.downcase)
  end

  def password=(arg)
    if arg.blank?
      #self.encrypted_password = nil
    else
      self.encrypted_password = Digest::MD5.hexdigest(arg)
    end
  end

  def self.random_password
    (0...8).map { (65 + rand(26)).chr }.join
    #'admin'
  end

  def random_password!
    random_password
    save
  end

  private
    def check_password_for_new_record
      User.random_password if new_record? && password.blank?
      true
    end
end
