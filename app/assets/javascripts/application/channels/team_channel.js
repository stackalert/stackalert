$(document).on("turbolinks:load", () => {
  const element = document.querySelector("div.row");
  if (element === null) {
    return;
  }
  const teamId = element.dataset.teamId;
  if (teamId === undefined) {
    return;
  }

  App.cable.subscriptions.create(
    {
      channel: "TeamChannel",
      team_id: teamId
    },
    {
      received(newCheck) {
        const checkId = $(newCheck).data("check-id");
        const oldCheck = $(`div[data-check-id="${checkId}"]`);
        oldCheck.replaceWith(newCheck);
      }
    }
  );
});
