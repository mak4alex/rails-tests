var Project = {

  taskFromAnchor: function(anchorElement) {
    return anchorElement.parents('tr');
  },

  previousTask: function(taskRow) {
    var result = taskRow.prev();
    return result.length > 0 ? result : null;
  },

  nextTask: function(taskRow) {
    var result = taskRow.next();
    return result.length > 0 ? result : null;
  },

  swapRows: function(firstRow, second_row) {
    second_row.detach();
    second_row.insertBefore(firstRow);
  },

  upClickOn: function(anchorElement) {
    var row = Project.taskFromAnchor(anchorElement);
    var previousRow = Project.previousTask(row);
    if (previousRow == null) return;
    Project.swapRows(previousRow, row);
    Project.ajaxCall(row.attr('id'), 'up');
  },

  downClickOn: function(anchorElement) {
    var row = Project.taskFromAnchor(anchorElement);
    var nextRow = Project.nextTask(row);
    if (nextRow == null) return;
    Project.swapRows(row, nextRow);
    Project.ajaxCall(row.attr('id'), 'down')
  },

  ajaxCall: function(domId, action) {
    var taskId = domId.split('_')[1];
    $.ajax({
      url: '/tasks/' + taskId + '/' + action + '.js'
      data: {'_method': 'PATCH'},
      type: 'POST'
    }).done(function(data) {
      Project.successfulUpdate(data);
    }).fail(function(data) {
      Project.failedUpdate(data);
    })
  },

  successfulUpdate: function(data) {

  },

  failedUpdate: function(data) {
    
  }

}

$(function() {
  $(document).on('click', '.up', function(event) {
    event.preventDefault();
    Project.upClickOn($(this));
  });
})

