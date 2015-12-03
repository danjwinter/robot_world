require_relative '../test_helper'

class RobotWorldTest < Minitest::Test

  def create_robot(num)
    num.times do |n|
      RobotWorld.create({:name          => "Bob#{n}",
                         :city          => "Denver#{n}",
                         :state         => "CO#{n}",
                         :avatar        => "Narwhal#{n}",
                         :birthdate     => "04/04/2014#{n}",
                         :date_hired    => "05/05/2015#{n}",
                         :department    => "domination#{n}"})
    end
  end

  def test_it_creates_a_robot
    create_robot(1)
    serial = RobotWorld.all.last.serial_number
    robot = RobotWorld.find(serial)

    assert_equal "Bob0", robot.name
    assert_equal serial, robot.serial_number
    assert_equal "Denver0", robot.city
    assert_equal "CO0", robot.state
    assert_equal "Narwhal0", robot.avatar
    assert_equal "04/04/20140", robot.birthdate
    assert_equal "05/05/20150", robot.date_hired
    assert_equal "domination0", robot.department
  end

  def test_all_returns_an_array_of_all_tasks
    create_robot(4)

    all_bots = RobotWorld.all

    assert_equal 4, all_bots.count
    assert_equal Array, all_bots.class
    assert_equal [Robot, Robot, Robot, Robot], all_bots.map {|bot| bot.class}
  end

  def test_find_returns_correct_robot
    create_robot(3)

    robot3 = RobotWorld.all.last

    assert_equal "Bob2", robot3.name
    refute_equal "Denver1", robot3.city
    assert_equal "Bob2", robot3.name
  end

  def test_update_edits_and_stores_attributes_for_correct_robot
    create_robot(1)
    updated_attributes = {:name          => "Frank",
                       :city          => "Atlanta",
                       :state         => "Georgia",
                       :avatar        => "Narwhal",
                       :birthdate     => "04/04/2014",
                       :date_hired    => "05/05/2015",
                       :department    => "domination"}
    id = RobotWorld.all.last.serial_number
    RobotWorld.update(id, updated_attributes)
    robot1 = RobotWorld.find(id)


    refute_equal "Bob0", robot1.name
    assert_equal "Frank", robot1.name
    assert_equal "Atlanta", robot1.city
    assert_equal "Georgia", robot1.state
  end

  def test_it_deletes_a_robot
    create_robot(3)
    total = RobotWorld.all.count

    RobotWorld.delete(RobotWorld.all.last.serial_number)
    assert_equal (total - 1), RobotWorld.all.count
  end
end