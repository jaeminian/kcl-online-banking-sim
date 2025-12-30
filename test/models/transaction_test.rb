## Authors: Ayan Ahmad (K19002255), Kevin Quah (k1921877), Jae Min An (k19034574), Daniela Stanciu (k1922053), Mihaela Peneva (k19026170) 

require 'test_helper'

class TransactionTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end

  def setup
    @transaction = Transaction.new({account: accounts(:one), receiver: 'Waterstones', amount: 15.5})
  end
  #Transaction Default
  test "default transaction should be valid" do
    assert @transaction.valid?
  end

  #receiver Name checks
  test "receiver should be at least 1 character" do
    @transaction.receiver = ""
    assert_not @transaction.valid?
  end

  test "receiver with 1 character is valid" do
    @transaction.receiver = "x"
    assert @transaction.valid?
  end

  #Amount checks
  test "amount should be a number" do
    @transaction.amount = "abc"
    assert_not @transaction.valid?
  end

  test "amount as a number is valid" do
    @transaction.amount = -100
    assert @transaction.valid?
  end

  #No fields can be blank
  test "receiver should not be blank" do
    @transaction.receiver = ""
    assert_not @transaction.valid?
  end

  test "amount should not be blank" do
    @transaction.amount = nil
    assert_not @transaction.valid?
  end

  test "every transaction belongs to an account" do
    @transaction.account = nil
    assert_not @transaction.valid?
  end

end