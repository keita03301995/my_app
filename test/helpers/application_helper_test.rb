require 'test_helper'

class ApplicationHelperTest < ActionView::TestCase
  test "full title helper" do
    assert_equal full_title, "my_app"
    assert_equal full_title("Help"), "Help | my_app"
  end
end

