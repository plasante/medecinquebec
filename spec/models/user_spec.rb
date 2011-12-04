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

require 'spec_helper'

describe User do
  
  # This is to create a new @attr object before each example
  before(:each) do
    @attr = {:first_name => "Pierre", :last_name => "Lasante", :email => "plasante@email.com"}
  end
  
  it "should create a new instance given valid attributes" do
    User.create(@attr)
  end
  
  describe "first name validation" do
    it "should require a first name" do
      no_first_name_user = User.new(@attr.merge(:first_name => ""))
      no_first_name_user.should_not be_valid
    end
    
    it "should reject first name that are too long" do
      long_first_name = "a" * 51
      long_first_name_user = User.new(@attr.merge(:first_name => long_first_name))
      long_first_name_user.should_not be_valid
    end
  end
  
  describe "last name validation" do
    it "should require a last name" do
      no_last_name_user = User.new(@attr.merge(:last_name => ""))
      no_last_name_user.should_not be_valid
    end
    
    it "should reject last name that are too long" do
      long_last_name = "a" * 51
      long_last_name_user = User.new(@attr.merge(:last_name => long_last_name))
      long_last_name_user.should_not be_valid
    end
  end
  
  describe "email validation" do
    it "should require an email address" do
      no_email_user = User.new(@attr.merge(:email => ""))
      no_email_user.should_not be_valid
    end
    
    it "should accept valid email addresses" do
      addresses = %w[pierre@email.com the_pierre@email.qc.ca pierre.lasante@email.com]
      addresses.each do |address|
        valid_email_user = User.new(@attr.merge(:email => address))
        valid_email_user.should be_valid
      end
    end
    
    it "should reject invalid email addresses" do
      addresses = %w[pierre@email,com the_pierre_at_email.org pierre.lasante@email.]
      addresses.each do |address|
        invalid_email_user = User.new(@attr.merge(:email => address))
        invalid_email_user.should_not be_valid
      end
    end
    
    it "should reject duplicate email addresses" do
      # Put a user into the database
      User.create!(@attr)
      user_with_duplicate_email = User.new(@attr)
      user_with_duplicate_email.should_not be_valid
    end
    
    it "should reject email addresses identical up to case" do
      upcased_email = @attr[:email].upcase
      User.create!(@attr.merge(:email => upcased_email))
      user_with_duplicate_email = User.new(@attr)
      user_with_duplicate_email.should_not be_valid
    end
  end
  
end
