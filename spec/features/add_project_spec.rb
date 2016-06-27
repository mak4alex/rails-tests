require 'rails_helper'

describe 'adding projects' do
  fixtures :all
  include Warden::Test::Helpers

  before(:example) do
    login_as users(:user)
  end

  it 'allows a user to create a project with tasks' do
    visit new_project_path
    fill_in 'Name', with: 'Project Boss'
    fill_in 'Tasks', with: "Tasks 1:3\nTasks 2:5"
    click_on('Create Project')
    visit projects_path
    project = Project.find_by_name('Project Boss')
    within("#project_#{project.id}") do
      expect(page).to have_selector(".name", text: "Project Boss")
      expect(page).to have_selector(".total-size", text: "8")
    end
  end
end
