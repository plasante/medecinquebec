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
  
  # Those attributes can be modified from a web browser
  attr_accessible :first_name, :last_name, :email
  
  validates :first_name, :presence => true,
                         :length   => { :maximum => 50 }
  
  validates :last_name,  :presence => true,
                         :length   => { :maximum => 50 }
  
  validates :email,      :presence   => true,
                         :format     => { :with => /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i},
                         :uniqueness => { :case_sensitive => false }
end
