require 'test_helper'

class ScripturableTest < ActiveSupport::TestCase
  test "truth" do
    assert_kind_of Module, Scripturable
  end
end
