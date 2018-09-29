$(document).ready(() => {
  $(document).on("turbolinks:load", () => {
    $(".dropdown").on("show.bs.dropdown", function() {
      $(this)
        .find(".dropdown-menu")
        .first()
        .stop(true, true)
        .slideDown(300);
    });
    $(".dropdown").on("hide.bs.dropdown", function() {
      $(this)
        .find(".dropdown-menu")
        .first()
        .stop(true, true)
        .slideUp(300);
    });
  });
});
