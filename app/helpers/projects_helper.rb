module ProjectsHelper
  def name_with_status(project)
    dom_class = project.on_schedule? ? 'on_schedule' : 'behind_schedule'
    content_tag(:span, project.name, class: dom_class)
  end

  def if_logged_in
    yield if logged_in?
  end
end
