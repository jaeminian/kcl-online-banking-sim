## Authors: Ayan Ahmad (K19002255), Kevin Quah (k1921877), Jae Min An (k19034574), Daniela Stanciu (k1922053), Mihaela Peneva (k19026170) 

require 'test_helper'

class UserTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end

  def setup
    @user = User.new({fname: 'jack', lname:'man', email:'jackman1@jackal.com' ,username: 'jackman', password: 'alphabeta', password_confirmation: 'alphabeta'})
  end
  #Username Default
  test "default user should be valid" do
    assert @user.valid?
  end

  #Matching Password Test
  test "user with non-matching passwords is invalid" do
    @user.password = 'betagamma'
    assert_not @user.valid?
  end

  #User Name Length checks, at limits and within
  test "username should be at least 3 characters" do
    @user.username = "x" * 2
    assert_not @user.valid?
  end

  test "username should be no more than 30 characters" do
    @user.username = "x" * 31
    assert_not @user.valid?
  end

  test "username with 3 characters is valid" do
    @user.username = "x" * 3
    assert @user.valid?
  end

  test "username with 30 characters is valid" do
    @user.username = "x" * 30
    assert @user.valid?
  end

  #First Name length checks, at limits and outside
  test "fname should be at least 2 characters" do
    @user.fname = "x"
    assert_not @user.valid?
  end

  test "fname should be no more than 100 characters" do
    @user.fname = "x" * 101
    assert_not @user.valid?
  end

  test "fname with 2 characters is valid" do
    @user.fname = "x" * 2
    assert @user.valid?
  end

  test "fname with 100 characters is valid" do
    @user.fname = "x" * 100
    assert @user.valid?
  end

  #First Name length checks, at limits and outside
  test "lname should be at least 2 characters" do
    @user.lname = "x"
    assert_not @user.valid?
  end

  test "lname should be no more than 100 characters" do
    @user.lname = "x" * 101
    assert_not @user.valid?
  end

  test "lname with 2 characters is valid" do
    @user.lname = "x" * 2
    assert @user.valid?
  end

  test "lname with 100 characters is valid" do
    @user.lname = "x" * 100
    assert @user.valid?
  end

  #Password length checks, at limits and outside
  test "password should have at least 6 characters" do
    @user.password = @user.password_confirmation = "x" * 5
    assert_not @user.valid?
  end

  test "password should be no more than 50 characters" do
    @user.password = @user.password_confirmation = "x" * 51
    assert_not @user.valid?
  end

  test "username should be stored in lowercase" do
    @user.username = "SHAUNSHEEP"
    @user.save
    assert_equal "shaunsheep", @user.username
  end

  test "username should not be blank" do
    @user.username = " " * 6
    assert_not @user.valid?
  end

  test "username should be unique not case sensitive" do
    duplicate_user = @user.dup
    duplicate_user.username = duplicate_user.username.upcase
    @user.save
    assert_not duplicate_user.valid?
  end

  test "password should not be blank" do
    @user.password = @user.password_confirmation = " " * 6
    assert_not @user.valid?
  end

  test "email should be unique not case sensitive" do
    duplicate_user = @user.dup
    duplicate_user.email = duplicate_user.email.upcase
    @user.save
    assert_not duplicate_user.valid?
  end

  test "email with invalid format should not be accepted" do
    @user.email = @user.email = "f" * 6
    assert_not @user.valid?
  end

  test "email with a valid format should be accepted" do
    @user.email = @user.email = "foo@bar.com"
    assert @user.valid?
  end

  test "secure password is 0 for default user" do
    assert_equal "0", @user.securelogin
  end

  

end