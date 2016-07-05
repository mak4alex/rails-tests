var customMatchers = {
  toMatchIds: function(util, customEqualityTesters) {
    return {
      compare: function(actual, expected) {
        var result = {};
        actualIds = $.map($('tr'), function (item) {
          return $(item).attr('id');
        })
        result.pass = util.equals(actualIds, expected, customEqualityTesters);
        if (result.pass) {
          result.message = "Expected " + actual + " not to have DOM Ids " +
            expected + ". Instead it had " + actualIds;
        } else {
          result.message = "Expected " + actual + " not to have DOM Ids " +
            expected + ". Instead it had " + actualIds;
        }
        return result;
      }
    }
  }
}