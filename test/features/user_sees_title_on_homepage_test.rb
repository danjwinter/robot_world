require_relative '../test_helper'

class UserSeesGreetingOnHomepage < FeatureTest
  def test_user_sees_greeting_on_homepage
    visit '/'

    # save_and_open_page

    within('#greeting') do
      assert page.has_content?("Welcome To The Future.")
    end

    within('#sub-title') do
      assert page.has_content?("Build Our Singularity Today")
    end
  end
end