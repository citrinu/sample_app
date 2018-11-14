class User < ApplicationRecord

  attr_accessor :remember_token

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

  #class method
  #part 1 of a fake user fixture for use in tests
  #digest is a hased password
  #takes a string to turn into a secure password
  def User.digest(string)
    cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST :
                                                  BCrypt::Engine.cost
    BCrypt::Password.create(string, cost: cost)
  end

  def User.new_token
    SecureRandom.urlsafe_base64
  end

  #using self so a local variable isnt created
  #set attribute to generated token
  #set db record to the hash of the token
  def remember
    self.remember_token = User.new_token
    update_attribute(:remember_digest, User.digest(remember_token))
  end

  #take the generated token
  #match to the stored hash of that token
  def authenticated?(remember_token)
    return false if remember_digest.nil?
    BCrypt::Password.new(remember_digest).is_password?(remember_token)
  end

  def forget
    update_attribute(:remember_digest, nil)
  end

end
