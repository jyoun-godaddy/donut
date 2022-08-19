require 'minitest/autorun'
require_relative './main.rb'

class TestDonut < MiniTest::Test
  def setup
    participants = [
      'yutaro',
      'claire',
      'katie',
      'josh',
      'james',
      'aniza',
    ]

    history_file_path =  '/tmp/history.json'
    # @donut = Donut.new(participants, history_file_path)
    @donut = true
  end

  test "test_creates_history_if_one_doesnt_exist" do
    # assert file created & participants in instance var
  end

  def test_loads_history_file_if_one_exist
    # assert file still exists & participants in instance var
  end

  def test_that_it_will_not_blend
    refute_match true, false
  end

  def test_that_will_be_skipped
    skip "test this later"
  end

  def test_access_setup
    assert_equal @donut, true
  end
end
