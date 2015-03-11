require 'bcrypt'

class User

  include DataMapper::Resource

  has n, :blogs, :through => Resource

  property :id,               Serial
  property :name,             String
  property :username,         String, :unique => true
  property :email,            String, :unique => true
  property :password_digest,  Text

  attr_reader :password
  attr_accessor :password_confirmation

  validates_confirmation_of :password, :message => "Sorry, your passwords don't match"
  validates_uniqueness_of :username, :email

  def password=(password)
    self.password_digest = BCrypt::Password.create(password)
  end

  def self.authenticate(username, password)
    user = first(:username => username)
    if user && BCrypt::Password.new(user.password_digest) == password
      user
    else
      nil
    end
  end

end

