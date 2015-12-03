require_relative '../test_helper'

class UserCanDeleteRobots < FeatureTest

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

  def test_user_can_delete_robots
    create_robot(1)

    visit '/robots'

    click_button('terminate')

    refute page.has_content?("Bob0")
    refute page.has_css?('#robot-title-1')
  end
end