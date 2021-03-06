require "rails_helper"

RSpec.feature "Deleting Exercise" do
  before do
    @owner = User.create(
      email: "owner@example.com",
      first_name: "Admin",
      last_name: "Owner",
      password: "password"
    )

    @owner_exer = @owner.exercises.create!(
      duration_in_min: 48,
      workout: "My body building activity",
      workout_date: Date.today
    )

    login_as(@owner)
  end

  scenario do
    visit "/"
    click_link "My Locker Room"

    link = "//a[contains(@href,
           '/users/#{@owner.id}/exercises/#{@owner_exer.id}')
           and .//text()='Destroy']"
    find(:xpath, link).click

    expect(page).to have_content("Exercise has been deleted")
  end
end
