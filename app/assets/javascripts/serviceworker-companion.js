// if (navigator.serviceWorker) {
//   navigator.serviceWorker
//     .register("/serviceworker.js", { scope: "./" })
//     .then(registration => {
//       console.log("[ServiceWorker]", "registered!", registration);
//       registration.pushManager
//         .subscribe({
//           userVisibleOnly: true,
//           applicationServerKey: window.vapidPublicKey
//         })
//         .then(subscription => {
//           $.post("/browser_pushes.json", {
//             browser_push: subscription.toJSON()
//           });
//         });
//     });
// }
//
// if (!("Notification" in window)) {
//   console.error(
//     "[ServiceWorker]",
//     "This browser does not support desktop notification"
//   );
// } else if (Notification.permission === "granted") {
//   console.log(
//     "[ServiceWorker]",
//     "Permission to receive notifications has been granted"
//   );
// } else if (Notification.permission !== "denied") {
//   Notification.requestPermission(permission => {
//     if (permission === "granted") {
//       console.log(
//         "[ServiceWorker]",
//         "Permission to receive notifications has been granted"
//       );
//     }
//   });
// }
