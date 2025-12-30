## Authors: Ayan Ahmad (K19002255), Kevin Quah (k1921877), Jae Min An (k19034574), Daniela Stanciu (k1922053), Mihaela Peneva (k19026170) 

require 'test_helper'

class ConsoleTest < ActiveSupport::TestCase
  def setup
    @console = Console.new(
      footer_b: "#1c2331",
      footer_t: "#fff",
      header_b: "#1c2331",
      header_t: "#fff",
      corona_b: "#145d8e",
      corona_t: "#fff",
      banner_b: "#14233c",
      banner_t: "#fff")
  end

  #Currency Default
  
  test "default console should be valid" do
    assert @console.valid?
  end
end
