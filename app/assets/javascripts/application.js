//= require govuk_toolkit
//= require_tree .

$(function(){
  GOVUK.primaryLinks.init('.primary-item');

  if (typeof ieVersion === 'undefined' || ieVersion > 6) {
    GOVUK.stickAtTopWhenScrolling.init();
  }
});
