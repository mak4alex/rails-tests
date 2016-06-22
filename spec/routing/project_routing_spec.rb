require 'rails_helper'

RSpec.describe 'project routing' do
  it 'routes projects' do
    expect(get: '/projects').to(
      route_to(controller: 'projects', action: 'index'))
    expect(post: '/projects').to(
      route_to(controller: 'projects', action: 'create'))
    expect(get: 'projects/new').to(
      route_to(controller: 'projects', action: 'new'))
    expect(get: 'projects/1').to(
      route_to(controller: 'projects', action: 'show', id: '1'))
    expect(delete: 'projects/1').to(
      route_to(controller: 'projects', action: 'destroy', id: '1'))
    
    expect(get: '/projects/search/fred').not_to be_routable
  end


end
