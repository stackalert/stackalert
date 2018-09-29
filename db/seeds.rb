CheckConfiguration.create!(name: 'github', values: [
  { name: 'Github API', endpoint: 'https://api.github.com', danger_threshold: 2000, warning_threshold: 1000 },
  { name: 'Github Web', endpoint: 'https://github.com', danger_threshold: 4000, warning_threshold: 2000}
])
CheckConfiguration.create!(name: 'bitbucket', values: [
  { name: 'Bitbucket API', endpoint: 'https://api.bitbucket.org/2.0/users/tutorials', danger_threshold: 2000, warning_threshold: 1000 },
  { name: 'Bitbucket Web', endpoint: 'https://bitbucket.org', danger_threshold: 4000, warning_threshold: 2000 }
])
CheckConfiguration.create!(name: 'heroku', values: [
  { name: 'Heroku API', endpoint: 'https://api.heroku.com/schema', danger_threshold: 2000, warning_threshold: 1000 },
  { name: 'Heroku Web', endpoint: 'https://www.heroku.com', danger_threshold: 4000, warning_threshold: 2000 },
  { name: 'Heroku ID', endpoint: 'https://id.heroku.com', danger_threshold: 4000, warning_threshold: 2000 }
])
CheckConfiguration.create!(name: 'rollbar', values: [
  { name: 'Rollbar API', endpoint: 'https://api.rollbar.com/', danger_threshold: 2000, warning_threshold: 1000 },
  { name: 'Rollbar Web', endpoint: 'https://rollbar.com', danger_threshold: 4000, warning_threshold: 2000 }
])
CheckConfiguration.create!(name: 'newrelic', values: [
  { name: 'Newrelic API', endpoint: 'https://api.newrelic.com/v2', danger_threshold: 2000, warning_threshold: 1000 },
  { name: 'Newrelic Documentation', endpoint: 'https://rpm.newrelic.com/api/explore', danger_threshold: 4000, warning_threshold: 2000 },
  { name: 'Newrelic Web', endpoint: 'https://newrelic.com', danger_threshold: 4000, warning_threshold: 2000 },
  { name: 'Newrelic Login', endpoint: 'https://login.newrelic.com/login', danger_threshold: 4000, warning_threshold: 2000 }
])
CheckConfiguration.create!(name: 'pusher', values: [
  { name: 'Pusher Web', endpoint: 'https://pusher.com/', danger_threshold: 4000, warning_threshold: 2000 },
  { name: 'Pusher Dashboard', endpoint: 'https://dashboard.pusher.com/accounts/sign_in', danger_threshold: 4000, warning_threshold: 2000 }
])
CheckConfiguration.create!(name: 'pubnub', values: [
  { name: 'Pubnub API', endpoint: 'http://pubsub.pubnub.com/', danger_threshold: 2000, warning_threshold: 1000 },
  { name: 'Pubnub Web', endpoint: 'https://www.pubnub.com/', danger_threshold: 4000, warning_threshold: 2000 },
  { name: 'Pubnub Admin', endpoint: 'https://admin.pubnub.com/#/login', danger_threshold: 4000, warning_threshold: 2000 }
])
