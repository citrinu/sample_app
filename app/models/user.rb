class User < ApplicationRecord

  #constant
  #allows invalid addresses that contain consecutive dots
  #pls fix
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i

  validates :name, presence: true, length: {maximum: 50}

    #checks if the given email format matches the regex
  validates :email, presence: true, length: {maximum: 255},
            format: { with: VALID_EMAIL_REGEX }, uniqueness: { case_sensitive: false }




end
