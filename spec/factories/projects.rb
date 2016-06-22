FactoryGirl.define do
  factory :project do
    name 'Project Runway'
    due_date { Date.today - rand(50) }
    slug { "#{name.downcase.gsub(' ', '_')}" }
  end
end