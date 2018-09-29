# Stack Alert

## Dependencies

- ruby
- yarn
- node

## Credentials

You need to create the following credentials using `rails credentials:setup`

```
# Used as the base secret for all MessageVerifiers in Rails, including the one protecting cookies.
secret_key_base:
vapid_public_key:
vapid_private_key:

# Optional, to synchronize user with mailchimp
mailchimp_api_key:

# Only needed if starting in production env
sentry_dsn:

aws:
  access_key_id:
  secret_access_key:

smtp:
  address:
  port:
  host:
  user_name:
  password:
  authentication:
  enable_starttls_auto:

private:
  user_name:
  password:

[env]:
  host:
  bitbucket_app_id:
  bitbucket_app_secret:
  github_app_id:
  github_app_secret:

  redis_url:
  slack_client_id:
  slack_client_secret:
  twitter_client_id:
  twitter_client_secret:

  # Optional, to synchronize user with mailchimp
  mailchimp_list_id:
  # Optional
  ga_tracker_id:
```

## Getting Started

After you have cloned this repo, run this start script:

    % ./bin/setup

Then run the rails server

    % rails s

You can now access:

* http://localhost:3000
