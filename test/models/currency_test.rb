## Authors: Ayan Ahmad (K19002255), Kevin Quah (k1921877), Jae Min An (k19034574), Daniela Stanciu (k1922053), Mihaela Peneva (k19026170) 

require 'test_helper'

class CurrencyTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end

  def setup
    @currency = Currency.new({id: 3, bigname: 'AmericanDollar', shortname:'USD'})
  end
  #Currency Default
  test "default currency should be valid" do
    assert @currency.valid?
  end


  #Currency Big Name Length checks, at limits and within
  test "bigname should be at least 3 characters" do
    @currency.bigname = "x" * 2
    assert_not @currency.valid?
  end

  test "bigname should be no more than 30 characters" do
    @currency.bigname = "x" * 31
    assert_not @currency.valid?
  end

  test "bigname with 3 characters is valid" do
    @currency.bigname = "x" * 3
    assert @currency.valid?
  end

  test "bigname with 30 characters is valid" do
    @currency.bigname = "x" * 30
    assert @currency.valid?
  end

  #Currency Short Name length checks, at limits and outside
  test "shortname should be at least 3 characters" do
    @currency.shortname = "x" * 2
    assert_not @currency.valid?
  end

  test "shortname should be no more than 3 characters" do
    @currency.shortname = "x" * 4
    assert_not @currency.valid?
  end

  test "shortname with 3 characters is valid" do
    @currency.shortname = "x" * 3
    assert @currency.valid?
  end

  #Currency Names checks
  test "bigname should be unique not case sensitive" do
    duplicate_currency = @currency.dup
    duplicate_currency.bigname = duplicate_currency.bigname.upcase
    @currency.save
    assert_not duplicate_currency.valid?
  end

  test "shortname should be unique not case sensitive" do
    duplicate_currency = @currency.dup
    duplicate_currency.shortname = duplicate_currency.shortname.upcase
    @currency.save
    assert_not duplicate_currency.valid?
  end

  test "bigname should not be blank" do
    @currency.bigname = " " * 6
    assert_not @currency.valid?
  end

  test "shortname should not be blank" do
    @currency.shortname = " " * 6
    assert_not @currency.valid?
  end

end