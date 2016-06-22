require 'rails_helper'


RSpec.describe ProjectsHelper, type: :helper do
  let(:project) { Project.new(name: 'Project Runway') }

  it 'augments with status info' do
    allow(project).to receive(:on_schedule?).and_return(true)
    actual = helper.name_with_status(project)
    expect(actual).to have_selector('.span.on_schedule', text: 'Project Runway')
  end

  it 'augments project name with status info behind schedule' do
    allow(project).to receive(:on_schedule?).and_return(false)
    actual = helper.name_with_status(project)
    expect(actual).to have_selector('span.behind_schedule', text: 'Project Runway')
  end

  it 'does not display if not logged_in' do
    expect(logged_in?),to be_falsy
    if_logged_in { 'logged in' }
    expect(output_buffer).to be_nil
  end

  it 'displays if logged in' do
    login_as users(:quentin)
    expect(logged_in?).to be_truthy
    expect(if_logged_in { 'logged in' }).to eq('logged in')
  end
end
