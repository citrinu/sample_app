class User #new class
  attr_accessor :first_name, :last_name, :email #get/setter methods

  def initialize(attributes = {}) # creates an empty hash
    @first_name = attributes[:first_name] #instance variables
    @last_name = attributes[:last_name]
    @email = attributes[:email] #available anywhere in the class
  end

  def full_name
    "#{@first_name},#{@last_name}"
  end

  def formatted_email
    "#{full_name} <#{@email}>"
  end

  def alpha
    "#{@last_name},#{@first_name}"
  end
end
