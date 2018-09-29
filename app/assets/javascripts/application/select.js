$(document).on("turbolinks:before-cache", () => {
  $("select").select2("destroy");
});

$(document).on("turbolinks:load", () => {
  $("select").select2({ theme: "bootstrap" });
});
