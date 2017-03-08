$(document).on("page:change", function() {
  return $('#comments-link').click(function(event) {
    $('#comments-section').fadeToggle();
    return $('#comments-body').focus();
  });
});
