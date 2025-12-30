## Authors: Ayan Ahmad (K19002255), Kevin Quah (k1921877), Jae Min An (k19034574), Daniela Stanciu (k1922053), Mihaela Peneva (k19026170) 

require 'test_helper'

class AccountTest < ActiveSupport::TestCase
  def setup
    @account = Account.new({user: users(:visionpulse), accnumber: "123456", sortcode: "12-34-56", accname: "Abcdef", curr_id: 1})
  end
  #Account Default
  test "default account should be valid" do
    assert @account.valid?
  end

  #User checks
  test "User should be present" do
    @account.user = nil
    assert_not @account.valid?
  end

  test "User should exist" do
    tempUser = User.new({fname: 'jack', lname:'man', email:'jackman1@jackal.com' ,username: 'jackman', password: 'alphabeta', password_confirmation: 'alphabeta'})
    @account.user = tempUser
    assert_not @account.valid?
  end

  test "User id should exist" do
    @account.user_id = nil
    assert_not @account.valid?
  end

  test "User id should match an existing user" do
    @account.user_id = 9000
    assert_not @account.valid?
  end

  #Account number checks
  test "Account number should not be blank" do
    @account.accnumber = ""
    assert_not @account.valid?
  end

  test "Account number should be in the correct format" do
    @account.accnumber = "abcdef"
    assert_not @account.valid?
  end

  test "Account number should be unique" do
    @account.accnumber = accounts(:one).accnumber
    assert_not @account.valid?
  end

=begin
  test "Account number should not be case sensitive" do

    assert_not @account.valid?
  end
=end

  #Sort code checks
  test "Sort code should be present" do
    @account.sortcode = nil
    assert_not @account.valid?
  end

  test "Sort code should be in the correct format" do
    @account.sortcode = "12-34-5"
    assert_not @account.valid?
  end

  #Account name checks
  test "Account name should be present" do
    @account.accname = nil
    assert_not @account.valid?
  end

  #Currency checks
=begin
  test "Currency should be present" do
    @account.currency = nil
    assert_not @account.valid?
  end

  test "Currency should exist" do
    tempCurrency = User.new({shortname: "short", bigname: "biggername"})
    @account.currency = tempCurrency
    assert_not @account.valid?
  end
=end

  test "Currency id should be present" do
    @account.curr_id = nil
    assert_not @account.valid?

  end
=begin
  test "Currency id should exist" do
    @account.curr_id = 9000
    assert_not @account.valid?
  end
=end
end
