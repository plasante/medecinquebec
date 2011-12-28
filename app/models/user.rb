# == Schema Information
#
# Table name: users
#
#  id         :integer         not null, primary key
#  first_name :string(255)
#  last_name  :string(255)
#  email      :string(255)
#  user_type  :integer
#  created_at :datetime
#  updated_at :datetime
#

class User < ActiveRecord::Base
  # To create a virtual password attribute
  attr_accessor :password
  
  # Those attributes can be accessed from a web browser
  attr_accessible :first_name, :last_name, :email, :password, :password_confirmation
  
  validates :first_name, :presence => true,
                         :length   => { :maximum => 50 }
  
  validates :last_name,  :presence => true,
                         :length   => { :maximum => 50 }
  
  validates :email,      :presence   => true,
                         :format     => { :with => /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i},
                         :uniqueness => { :case_sensitive => false }
  
  validates :password,   :presence     => true,
                         :confirmation => true,
                         :length       => { :within => 6..40 }
                         
  before_save :encrypt_password
  
  # Return true if the user's password matches the submitted password.
  def has_password?( submitted_password )
    encrypted_password == encrypt(submitted_password)
  end
  
  def self.authenticate( email , submitted_password )
    user = self.find_by_email( email )
    return nil if user.nil?
    return user if user.has_password?(submitted_password)
    return nil  # This line is redondant but self explanatory.
  end
  
  def self.authenticate_with_salt(id, cookie_salt)
    user = find_by_id(id)
    (user && user.salt == cookie_salt) ? user : nil
  end
  
private
  
  def encrypt_password
    self.salt = make_salt unless has_password?(self.password)
    self.encrypted_password = encrypt(self.password)
  end

  def encrypt(string)
    secure_hash("#{self.salt}--#{string}")
  end

  def make_salt
    secure_hash("#{Time.now.utc}--#{self.password}")
  end

  def secure_hash(string)
    Digest::SHA2.hexdigest(string)
  end
end
