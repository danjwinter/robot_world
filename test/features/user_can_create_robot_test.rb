require_relative '../test_helper'

class UserCanCreateRobot < FeatureTest
  def test_user_can_create_new_robot

    visit '/robots/new'

    fill_in('robot[name]', with: "Bob")
    fill_in('robot[city]', with: "Denver")
    select "Colorado", :from => "robot[state]"
    # find('robot[state]').find(:xpath, 'option[6]').select_option
    fill_in('robot[avatar]', with: "Narwhal")
    fill_in('robot[birthdate]', with: "04/04/2004")
    fill_in('robot[date_hired]', with: "05/05/2005")
    choose('domination')
    click_button('submit')

    assert_equal '/robots', current_path

    id = RobotWorld.all.last.serial_number

    within("#robot-title-#{id}") do
      assert page.has_content?("Bob")
      assert page.has_content?("Secret Agent #{id}")
    end
  end
end