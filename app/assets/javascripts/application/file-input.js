$(document).on("turbolinks:load", () => {
  $(".custom-file-input").on("change", function() {
    const fileName = $(this)
      .val()
      .split("\\")
      .pop();
    $(this)
      .next(".custom-file-label")
      .addClass("selected")
      .html(fileName);
  });
});
