$(document).on("turbolinks:load", () => {
  $(".card-search input").on("keyup", event => {
    const value = $(event.target)
      .val()
      .toLowerCase();

    $("div[data-search-name]").each((_, element) => {
      if (
        $(element)
          .data("search-name")
          .toLowerCase()
          .indexOf(value) === -1
      ) {
        $(element).hide();
        $(element).removeClass("d-flex");
      } else {
        $(element).addClass("d-flex");
        $(element).hide();
      }
    });
  });
});
