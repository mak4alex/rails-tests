require 'test_helper'

class ProjectTest < ActiveSupport::TestCase

  test 'let us stub an object' do
    project = Project.new(name: 'Project Greenlight')
    project.stubs(:name)
    assert_nil(project.name)
  end

  test 'let us stub an object again' do
    project = Project.new(name: 'Project Greenlight')
    project.stubs(:name).returns('Fred')
    assert_equal('Fred', project.name)
  end

  test 'let us stub a class' do
    Project.stubs(:find).returns(Project.new(:name => 'Project Greenlight'))
    project = Project.find(1)
    assert_equal('Project Greenlight', project.name)
  end

  test 'stub with multiple returns' do
    stubby = Project.new
    stubby.stubs(:user_count).returns(1,2)
    assert_equal(1, stubby.user_count)
    assert_equal(2, stubby.user_count)
    assert_equal(2, stubby.user_count)
  end

end