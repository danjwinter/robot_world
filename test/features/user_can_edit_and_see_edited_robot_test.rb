require_relative '../test_helper'

class UserCanSeeAndDeleteRobots < FeatureTest

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

  def test_user_can_edit_and_see_edited_robots
    create_robot(1)

    visit '/robots'

    id = RobotWorld.all.last.serial_number

    click_link("Reprogram")
    assert_equal "/robots/#{id}/edit", current_path
    fill_in('robot[name]', with: "Frank")
    fill_in('robot[city]', with: "Atlanta")
    select "Colorado", :from => "robot[state]"
    fill_in('robot[avatar]', with: "Narwhal")
    fill_in('robot[birthdate]', with: "04/04/2004")
    fill_in('robot[date_hired]', with: "05/05/2005")
    choose('domination')
    click_button('submit')



    within('#robo-data') do
      assert page.has_content?("Frank")
    end
  end
end