require_relative '../test_helper'

class RobotTest < Minitest::Test
  def test_it_assigns_attributes_correctly
    robot = Robot.new({"name"          => "Bob",
                       "serial_number" => 1,
                       "city"          => "Denver",
                       "state"         => "CO",
                       "avatar"        => "Narwhal",
                       "birthdate"     => "04/04/2014",
                       "date_hired"    => "05/05/2015",
                       "department"    => "domination"})

    assert_equal "Bob", robot.name
    assert_equal 1, robot.serial_number
    assert_equal "Denver", robot.city
    assert_equal "CO", robot.state
    assert_equal "Narwhal", robot.avatar
    assert_equal "04/04/2014", robot.birthdate
    assert_equal "05/05/2015", robot.date_hired
    assert_equal "domination", robot.department
  end
end