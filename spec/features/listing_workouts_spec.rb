require "rails_helper"

RSpec.feature "Listing Exercise" do
  before do
    @jason = User.create!(
      email: "jason@test.com",
      first_name: "Jason",
      last_name: "Bourne",
      password: "password"
    )

    login_as(@jason)

    @e1 = @jason.exercises.create(
      duration_in_min: 20,
      workout: "My body building activity",
      workout_date: Date.today
    )

    @e2 = @jason.exercises.create(
      duration_in_min: 55,
      workout: "Weight lifting",
      workout_date: Date.today
    )
    @e3 = @jason.exercises.create(
      duration_in_min: 35,
      workout: "On treadmill",
      workout_date: 8.days.ago
    )
  end

  scenario "shows user's workout for last 7 days" do
    visit "/"
    click_link "My Dashboard"

    expect(page).to have_content(@e1.duration_in_min)
    expect(page).to have_content(@e1.workout)
    expect(page).to have_content(@e1.workout_date)

    expect(page).to have_content(@e2.duration_in_min)
    expect(page).to have_content(@e2.workout)
    expect(page).to have_content(@e2.workout_date)

    expect(page).not_to have_content(@e3.duration_in_min)
    expect(page).not_to have_content(@e3.workout)
    expect(page).not_to have_content(@e3.workout_date)
  end

  scenario "shows no exercises if none created" do
    @jason.exercises.delete_all

    visit "/"
    click_link "My Dashboard"

    expect(page).to have_content("No Workouts Yet")
  end
end