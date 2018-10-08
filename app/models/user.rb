class User < ApplicationRecord

  #callback
  #before being saved to the database,fix for case sensivity
  before_save {self.email = email.downcase}

  #constant
  #allows invalid addresses that contain consecutive dots
  #pls fix
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i

  validates :name, presence: true, length: {maximum: 50}

    #checks if the given email format matches the regex
  validates :email, presence: true, length: {maximum: 255},
            format: { with: VALID_EMAIL_REGEX }, uniqueness: { case_sensitive: false }

  #will save a secure hashed password to db
  #will have validations + password confirmation
  #will authenticate when password is correct
  #provided by bcrypt http://en.wikipedia.org/wiki/Bcrypt
  has_secure_password
  validates :password, presence: true, length: {minimum: 6}

end
