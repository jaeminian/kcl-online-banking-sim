## Authors: Ayan Ahmad (K19002255), Kevin Quah (k1921877), Jae Min An (k19034574), Daniela Stanciu (k1922053), Mihaela Peneva (k19026170) 

require 'test_helper'

class ConsolesControllerTest < ActionDispatch::IntegrationTest

  test "get index should redirect to accounts page when not logged in as admin" do
    user = users(:visionpulse)
    log_in_as(user)
    get "/admin"
    assert_redirected_to accounts_path
  end

  test "get index should redirect to login if not logged in" do
    get "/admin"
    assert_redirected_to accounts_path
    follow_redirect!
    assert_redirected_to controller: "sessions", action: "new"
  end

  test "should be able to update consoles with valid data when logged in" do
    user = users(:superuser)
    log_in_as(user)
    console = consoles(:one)
    new_footer_b = "orange"
    assert_no_difference('Console.count') do
      patch console_path(console), params: { console: { footer_b: new_footer_b } }
    end
    assert_redirected_to consoles_path
    console.reload
    assert_equal new_footer_b, console.footer_b
  end

  test "should not be able to update consoles with valid data when not logged in" do
    console = consoles(:one)
    new_footer_b = "red"
    old_footer_b = console.footer_b
    assert_no_difference('Console.count') do
      patch console_path(console), params: { console: { footer_b: new_footer_b } }
    end
    assert_redirected_to accounts_path
    follow_redirect!
    assert_redirected_to controller: "sessions", action: "new"
    console.reload
    assert_equal old_footer_b, console.footer_b
  end

end
