$(document).on("turbolinks:request-start", () => {
  $(".loading-container").removeClass("invisible");
});

$(document).on("turbolinks:request-end", () => {
  $(".loading-container").addClass("invisible");
});

$(document).on("ajax:before", () => {
  $(".loading-container").removeClass("invisible");
});
