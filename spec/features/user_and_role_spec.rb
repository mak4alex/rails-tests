require 'rails_helper'

describe 'with users and roles' do
  
  def log_in_as(user)
    visit new_user_session_path
    fill_in 'user_email', with: user.email
    fill_in 'user_password', with: user.password
    click_button 'Log in'
  end

  let(:user) { User.create(email: 'test@example.com', password: 'password') }

  it 'allows a logged-in user to view the project index page' do
    log_in_as(user)
    visit(projects_path)
    expect(current_path).to eq(projects_path)
  end

  it 'does not allow user to see the project page if not logged in' do
    visit(projects_path)
    expect(current_path).to eq(new_user_session_path)
  end

  describe 'roles' do
    let(:project) { Project.create(name: 'Project Gutenberg') }

    it 'allows a user who is part of a project to see the project' do
      project.roles.create(user: user)
      log_in_as(user)
      visit(projects_path(project))
      expect(current_path).to eq(projects_path(project))
    end

    it 'does now allow a user who is not part of a project to see that project' do
      log_in_as(user)
      visit(project_path(project))
      expect(current_path).not_to eq(project_path(project))
    end

    it 'allows users to only see projects they are a part of on the index page' do
      my_project = create :project
      my_project.roles.create!(user: user)
      not_my_project = create :project 
      log_in_as(user)
      visit projects_path
      expect(page).to have_selector("#project_#{my_project.id}")
      expect(page).not_to have_selector("#project_#{not_my_project.id}")
    end

  end

end
