describe('with a list of tasks', function() {
  beforeEach(function() {
    jasmine.addMatchers(customMatchers)
    var table = affix('table');
    table.affix('tr.task#task_1 a.up');
    table.affix('tr.task#task_2 a.up+a.down');
    table.affix('tr.task#task_3 a.up');    
    this.server = sinon.fakeServer.create();
    this.server.fakeHTTPMethods = true;
  });

  it('correctly processes an up click', function() {
    $('#task_2 .up').click();
    expect($('tr')).toMatchDomIds(['task_2', 'task_1', 'task_3']);
  });

  it('correctly processes a down click', function() {
    $('#task_2 .down').click();
    expect($('tr')).toMatchDomIds(['task_1', 'task_3', 'task_2'])
  })

  describe('with a successful Ajax call', function () {
    beforeEach(function() {
      this.server.respondWith('PATCH', '/tasks/2/up.js',
        "{ task_id: 2, new_order: 1 }");
    })

    it('invokes a callback on success', function() {
      spyOn(Project, 'successfulUpdate').and.callThrought();
      $('#task_2 .up').click();
      this.server.respond();
      expect(Project.successfulUpdate).toHaveBeenCalled();
    })
  })

  describe('with an unsuccessful Ajax call', function() {
    beforeEach(function() {
      this.server.respondWith('PATCH', '/tasks/2/up.js',
        [500, {}, ""]);
    });

    it('invokes a callback on failure', function() {
      spyOn(Project, "failedUpdate").and.callThrought();
      $('#task_2 .up').click();
      this.server.respond();
      expect(Project.failedUpdate).toHaveBeenCalled();
    });

  });

  afterEach(function() {
    this.server.restore();
  });

});
