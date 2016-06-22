require 'task_helper'

class TaskTest < ActiveSupport::TestCase

  test 'a completed task is complete' do
    task = Task.new
    refute(task.complete?)
    task.mark_competed
    assert(task.complete?)
  end

  test 'an uncompeled task does not count toward velocity'
end
