class InitDb < ActiveRecord::Migration[5.1]
  def up
    # enable_extension "plpgsql"
    enable_extension "hstore"
    # enable_extension "timescaledb"
    # enable_extension "postgis"
    enable_extension "pgcrypto"

    ActiveMedian.create_function

    create_table "ahoy_messages", id: :uuid, force: :cascade do |t|
      t.string "token"
      t.text "to"
      t.uuid "user_id"
      t.string "user_type"
      t.string "mailer"
      t.text "subject"
      t.datetime "sent_at"
      t.datetime "opened_at"
      t.datetime "clicked_at"
      t.index ["token"], name: "index_ahoy_messages_on_token"
      t.index ["user_id", "user_type"], name: "index_ahoy_messages_on_user_id_and_user_type"
    end

    create_table :invites, id: :uuid do |t|
      t.string :email
      t.string :token
      t.uuid :sender_id
      t.uuid :recipient_id
      t.uuid :invitable_id
      t.string  :invitable_type
      t.timestamps
      t.index :email
      t.index :token
      t.index [:invitable_id, :invitable_type]
      t.index :recipient_id
      t.index :sender_id
    end

    create_table "alerts", id: :uuid, force: :cascade do |t|
      t.uuid "team_id", null: false
      t.string "name", default: "", null: false
      t.string "slug", null: false
      t.integer "alert_channels_count", default: 0, null: false
      t.datetime "deleted_at"
      t.index ["team_id"], name: "index_alerts_on_team_id"
      t.index ["deleted_at"], name: "index_alerts_on_deleted_at"
      t.datetime "created_at", null: false
      t.datetime "updated_at", null: false
    end

    create_table "alerts_checks", id: :uuid, force: :cascade do |t|
      t.uuid "alert_id", null: false
      t.uuid "check_id", null: false
      t.datetime "created_at", null: false
      t.datetime "updated_at", null: false
      t.index ["alert_id"], name: "index_alerts_checks_on_alert_id"
      t.index ["check_id"], name: "index_alerts_checks_on_check_id"
    end

    create_table "check_certificates", id: :uuid, force: :cascade do |t|
      t.uuid "check_id", null: false
      t.date "valid_on", null: false
      t.date "valid_until", null: false
      t.string "issuer", default: "", null: false
      t.datetime "created_at", null: false
      t.datetime "updated_at", null: false
      t.index ["check_id"], name: "index_check_certificates_on_check_id"
    end

    create_table "check_domains", id: :uuid, force: :cascade do |t|
      t.uuid "check_id", null: false
      t.date "valid_on"
      t.date "valid_until"
      t.string "registrar", default: "", null: false
      t.text "raw", null: false
      t.datetime "created_at", null: false
      t.datetime "updated_at", null: false
      t.index ["check_id"], name: "index_check_domains_on_check_id"
    end

    create_table "checks", id: :uuid, force: :cascade do |t|
      t.uuid "team_id", null: false
      t.uuid "status_page_id"
      t.string "name", default: "", null: false
      t.string "slug", null: false
      t.string "endpoint", default: "", null: false
      t.integer "warning_threshold", default: 1000, null: false
      t.integer "danger_threshold", default: 2000, null: false
      t.integer "row_order"
      t.integer "check_pings_count", default: 0, null: false
      t.integer "check_statistics_count", default: 0, null: false
      t.datetime "created_at", null: false
      t.datetime "updated_at", null: false
      t.integer "every", default: 1, null: false
      t.datetime "deleted_at"
      t.index ["deleted_at"], name: "index_checks_on_deleted_at"
      t.index ["status_page_id"], name: "index_checks_on_status_page_id"
      t.index ["team_id"], name: "index_checks_on_team_id"
    end

    create_table "alert_events", id: :uuid, force: :cascade do |t|
      t.uuid "alert_channel_id", null: false
      t.uuid "alert_rule_id", null: false
      t.boolean "success", default: false, null: false
      t.string "check_endpoint", null: false
      t.datetime "created_at", null: false
      t.datetime "updated_at", null: false
      t.index ["alert_channel_id"], name: "index_alert_events_on_alert_channel_id"
      t.index ["alert_rule_id"], name: "index_alert_events_on_alert_rule_id"
    end

    create_table "alert_channels", id: :uuid, force: :cascade do |t|
      t.uuid "alert_id", null: false
      t.string "type", null: false
      t.string "email"
      t.string "confirmation_token"
      t.datetime "confirmed_at"
      t.datetime "confirmation_sent_at"
      t.string "unconfirmed_email"
      t.string "endpoint"
      t.string "phone_number"
      t.uuid "team_identity_id"
      t.string "slack_channel"
      t.datetime "deleted_at"
      t.integer "alert_events_count", default: 0, null: false
      t.index ["alert_id"], name: "index_alert_channels_on_team_id"
      t.index ["deleted_at"], name: "index_alert_channels_on_deleted_at"
      t.datetime "created_at", null: false
      t.datetime "updated_at", null: false
    end

    create_table "user_identities", id: :uuid, force: :cascade do |t|
      t.uuid "user_id", null: false
      t.string "provider", null: false
      t.string "uid", null: false
      t.string "oauth_token"
      t.string "oauth_expires"
      t.string "oauth_secret"
      t.datetime "created_at", null: false
      t.datetime "updated_at", null: false
      t.datetime "deleted_at"
      t.index ["provider", "uid"], name: "index_user_identities_on_provider_and_uid", unique: true
      t.index ["deleted_at"], name: "index_user_identities_on_deleted_at"
      t.index ["user_id"], name: "index_identities_on_user_id"
    end

    create_table "status_page_incidents", id: :uuid, force: :cascade do |t|
      t.uuid "status_page_id", null: false
      t.uuid "user_id", null: false
      t.integer "severity", default: 0, null: false
      t.text "body"
      t.datetime "created_at", null: false
      t.datetime "updated_at", null: false
      t.datetime "deleted_at"
      t.index ["deleted_at"], name: "index_status_page_incidents_on_deleted_at"
      t.index ["status_page_id"], name: "index_status_page_incidents_on_status_page_id"
    end

    create_table "check_configurations", id: :uuid, force: :cascade do |t|
      t.string "name", default: "", null: false
      t.hstore "values", default: [], null: false, array: true
      t.datetime "created_at", null: false
      t.datetime "updated_at", null: false
      t.index ["name"], name: "index_check_configurations_on_name", unique: true
    end

    create_table "check_pings", id: :uuid, force: :cascade do |t|
      t.uuid "check_id", null: false
      t.integer "http_code", default: 0, null: false
      t.integer "total_time", default: 0, null: false
      t.integer "state", default: 0, null: false
      t.datetime "created_at", null: false
      t.datetime "updated_at", null: false
      t.integer "name_lookup_time", null: false
      t.integer "connect_time", null: false
      t.integer "app_connect_time", null: false
      t.integer "pre_transfer_time", null: false
      t.integer "redirect_time", null: false
      t.integer "start_transfer_time", null: false
      t.index ["state"], name: "index_check_pings_on_state"
      t.index ["check_id"], name: "index_check_pings_on_check_id"
      t.index ["created_at"], name: "check_pings_created_at_idx", order: { created_at: :desc }
    end

    # execute("SELECT create_hypertable('check_pings', 'created_at')")

    create_table "mailkick_opt_outs", id: :uuid, force: :cascade do |t|
      t.string "email"
      t.uuid "user_id"
      t.string "user_type"
      t.boolean "active", default: true, null: false
      t.string "reason"
      t.string "list"
      t.datetime "created_at", null: false
      t.datetime "updated_at", null: false
      t.index ["email"], name: "index_mailkick_opt_outs_on_email"
      t.index ["user_id", "user_type"], name: "index_mailkick_opt_outs_on_user_id_and_user_type"
    end

    create_table "team_members", id: :uuid, force: :cascade do |t|
      t.uuid "user_id", null: false
      t.uuid "team_id", null: false
      t.datetime "created_at", null: false
      t.datetime "updated_at", null: false
      t.datetime "deleted_at"
      t.index ["deleted_at"], name: "index_team_members_on_deleted_at"
      t.index ["team_id"], name: "index_team_members_on_team_id"
      t.index ["user_id"], name: "index_team_members_on_user_id"
    end

    create_table "oauth_access_grants", id: :uuid, force: :cascade do |t|
      t.uuid "resource_owner_id", null: false
      t.uuid "application_id", null: false
      t.string "token", null: false
      t.integer "expires_in", null: false
      t.text "redirect_uri", null: false
      t.datetime "created_at", null: false
      t.datetime "revoked_at"
      t.string "scopes"
      t.index ["application_id"], name: "index_oauth_access_grants_on_application_id"
      t.index ["token"], name: "index_oauth_access_grants_on_token", unique: true
    end

    create_table "oauth_access_tokens", id: :uuid, force: :cascade do |t|
      t.uuid "resource_owner_id"
      t.uuid "application_id"
      t.string "token", null: false
      t.string "refresh_token"
      t.integer "expires_in"
      t.datetime "revoked_at"
      t.datetime "created_at", null: false
      t.string "scopes"
      t.string "previous_refresh_token", default: "", null: false
      t.index ["application_id"], name: "index_oauth_access_tokens_on_application_id"
      t.index ["refresh_token"], name: "index_oauth_access_tokens_on_refresh_token", unique: true
      t.index ["resource_owner_id"], name: "index_oauth_access_tokens_on_resource_owner_id"
      t.index ["token"], name: "index_oauth_access_tokens_on_token", unique: true
    end

    create_table "oauth_applications", id: :uuid, force: :cascade do |t|
      t.string "name", null: false
      t.string "uid", null: false
      t.string "secret", null: false
      t.text "redirect_uri", null: false
      t.string "scopes", default: "", null: false
      t.datetime "created_at", null: false
      t.datetime "updated_at", null: false
      t.uuid "owner_id"
      t.string "owner_type"
      t.index ["owner_id", "owner_type"], name: "index_oauth_applications_on_owner_id_and_owner_type"
      t.index ["uid"], name: "index_oauth_applications_on_uid", unique: true
    end

    create_table "shift_openings", id: :uuid, force: :cascade do |t|
      t.string "days", null: false
      t.time "starts_at", null: false
      t.time "ends_at", null: false
      t.datetime "deleted_at"
      t.index ["deleted_at"], name: "index_shift_openings_on_deleted_at"
      t.datetime "created_at", null: false
      t.datetime "updated_at", null: false
    end

    create_table "plans", id: :uuid, force: :cascade do |t|
      t.string "name", default: "", null: false
      t.string "stripe_id"
      t.integer "amount", default: 0, null: false
      t.string "interval", null: false
      t.datetime "created_at", null: false
      t.datetime "updated_at", null: false
      t.index ["name"], name: "index_plans_on_name", unique: true
    end

    create_table "roles", id: :uuid, force: :cascade do |t|
      t.string "name"
      t.string "resource_type"
      t.uuid "resource_id"
      t.datetime "deleted_at"
      t.index ["deleted_at"], name: "index_roles_on_deleted_at"
      t.datetime "created_at", null: false
      t.datetime "updated_at", null: false
      t.index ["name", "resource_type", "resource_id"], name: "index_roles_on_name_and_resource_type_and_resource_id"
    end

    create_table "roles_users", id: :uuid, force: :cascade do |t|
      t.uuid "user_id"
      t.uuid "role_id"
      t.datetime "deleted_at"
      t.index ["deleted_at"], name: "index_role_team_members_on_deleted_at"
      t.index ["user_id", "role_id"], name: "index_roles_users_on_user_id_and_role_id"
    end

    create_table "alert_rules", id: :uuid, force: :cascade do |t|
      t.uuid "alert_id", null: false
      t.integer "name", null: false, default: 0
      t.integer "threshold", default: 0, null: false
      t.datetime "deleted_at"
      t.index ["deleted_at"], name: "index_alert_rules_on_deleted_at"
      t.datetime "created_at", null: false
      t.datetime "updated_at", null: false
      t.index ["alert_id"], name: "index_alert_rules_on_alert_id"
    end

    create_table "shifts", id: :uuid, force: :cascade do |t|
      t.uuid "team_id", null: false
      t.uuid "shift_opening_id", null: false
      t.uuid "alert_id", null: false
      t.datetime "created_at", null: false
      t.datetime "updated_at", null: false
      t.string "name", default: ""
      t.string "slug", null: false
      t.datetime "deleted_at"
      t.index ["deleted_at"], name: "index_shifts_on_deleted_at"
      t.index ["alert_id"], name: "index_shifts_on_alert_id"
      t.index ["team_id"], name: "index_shifts_on_team_id"
      t.index ["shift_opening_id"], name: "index_shifts_on_opening_id"
    end

    create_table "team_identities", id: :uuid, force: :cascade do |t|
      t.uuid "team_id", null: false
      t.string "provider", null: false
      t.string "uid", null: false
      t.string "name", null: false
      t.string "oauth_token"
      t.string "oauth_expires"
      t.string "oauth_secret"
      t.datetime "created_at", null: false
      t.datetime "updated_at", null: false
      t.datetime "deleted_at"
      t.index ["provider", "uid"], name: "index_team_identities_on_provider_and_uid", unique: true
      t.index ["deleted_at"], name: "index_team_identities_on_deleted_at"
      t.index ["team_id"], name: "index_team_identities_on_team_id"
    end

    create_table "status_pages", id: :uuid, force: :cascade do |t|
      t.uuid "team_id", null: false
      t.string "title", default: "", null: false
      t.text "header"
      t.text "footer"
      t.string "domain_name"
      t.string "subdomain", null: false, default: ""
      t.integer "status_page_subscribers_count", default: 0, null: false
      t.integer "status_page_incidents_count", default: 0, null: false
      t.datetime "deleted_at"
      t.index ["deleted_at"], name: "index_status_pages_on_deleted_at"
      t.index ["team_id"], name: "index_status_pages_on_team_id"
      t.datetime "created_at", null: false
      t.datetime "updated_at", null: false
    end

    create_table "status_page_subscribers", id: :uuid, force: :cascade do |t|
      t.uuid "status_page_id", null: false
      t.string "email", default: "", null: false
      t.datetime "created_at", null: false
      t.datetime "updated_at", null: false
      t.datetime "deleted_at"
      t.index ["deleted_at"], name: "index_status_page_subscribers_on_deleted_at"
      t.index ["status_page_id"], name: "index_subscribers_on_status_page_id"
    end

    create_table "teams", id: :uuid, force: :cascade do |t|
      t.string "name", default: "", null: false
      t.string "slug", null: false
      t.string "time_zone", default: "UTC", null: false
      t.integer "checks_count", default: 0, null: false
      t.integer "shifts_count", default: 0, null: false
      t.integer "alerts_count", default: 0, null: false
      t.integer "team_members_count", default: 0, null: false
      t.datetime "created_at", null: false
      t.datetime "updated_at", null: false
      t.datetime "deleted_at"
      t.index ["deleted_at"], name: "index_teams_on_deleted_at"
      t.index ["slug"], name: "index_teams_on_slug", unique: true
    end

    create_table "users", id: :uuid, force: :cascade do |t|
      t.string "name", default: "", null: false
      t.string "slug", null: false
      t.string "email", default: "", null: false
      t.integer "sign_in_count", default: 0, null: false
      t.datetime "current_sign_in_at"
      t.datetime "last_sign_in_at"
      t.string "current_sign_in_ip"
      t.string "last_sign_in_ip"
      t.string "confirmation_token"
      t.datetime "confirmed_at"
      t.datetime "confirmation_sent_at"
      t.string "unconfirmed_email"
      t.datetime "created_at", null: false
      t.datetime "updated_at", null: false
      t.datetime "deleted_at"
      t.index ["deleted_at"], name: "index_users_on_deleted_at"
      t.index ["email"], name: "index_users_on_email", unique: true
    end

    create_table "version_associations", id: :uuid, force: :cascade do |t|
      t.uuid "version_id"
      t.string "foreign_key_name", null: false
      t.uuid "foreign_key_id"
      t.index ["foreign_key_name", "foreign_key_id"], name: "index_version_associations_on_foreign_key"
      t.index ["version_id"], name: "index_version_associations_on_version_id"
    end

    create_table "versions", id: :uuid, force: :cascade do |t|
      t.string "item_type", null: false
      t.uuid "item_id", null: false
      t.string "event", null: false
      t.string "whodunnit"
      t.text "object"
      t.datetime "created_at"
      t.string "transaction_id"
      t.index ["item_type", "item_id"], name: "index_versions_on_item_type_and_item_id"
      t.index ["transaction_id"], name: "index_versions_on_transaction_id"
    end

    create_table :active_storage_blobs, id: :uuid do |t|
      t.string   :key,        null: false
      t.string   :filename,   null: false
      t.string   :content_type
      t.text     :metadata
      t.bigint   :byte_size,  null: false
      t.string   :checksum,   null: false
      t.datetime :created_at, null: false

      t.index [ :key ], unique: true
    end

    create_table :active_storage_attachments, id: :uuid do |t|
      t.string     :name,     null: false
      t.string :record_type,  null: false
      t.uuid   :record_id,    null: false
      t.uuid   :blob_id,      null: false

      t.datetime :created_at, null: false

      t.index [ :record_type, :record_id, :name, :blob_id ], name: "index_active_storage_attachments_uniqueness", unique: true
    end

    create_table :activities, id: :uuid do |t|
      t.belongs_to :trackable, :polymorphic => true
      t.belongs_to :owner, :polymorphic => true
      t.string  :key
      t.text    :parameters
      t.belongs_to :recipient, :polymorphic => true

      t.timestamps
    end

    add_index :activities, [:trackable_id, :trackable_type]
    add_index :activities, [:owner_id, :owner_type]
    add_index :activities, [:recipient_id, :recipient_type]

    create_table :browser_pushes, id: :uuid do |t|
      t.uuid :user_id, null: false
      t.text :endpoint, null: false
      t.text :p256dh, null: false
      t.string :auth, null: false

      t.timestamps
    end
    add_index :browser_pushes, [:user_id], unique: true

    add_foreign_key "alert_channels", "alerts"
    add_foreign_key "alerts", "teams"
    add_foreign_key "alerts_checks", "alerts"
    add_foreign_key "checks", "teams"
    add_foreign_key "alerts_checks", "checks"
    add_foreign_key "check_certificates", "checks"
    add_foreign_key "check_domains", "checks"
    add_foreign_key "checks", "status_pages"
    add_foreign_key "alert_events", "alert_channels"
    add_foreign_key "alert_events", "alert_rules"
    add_foreign_key "user_identities", "users"
    add_foreign_key "team_identities", "teams"
    add_foreign_key "status_page_incidents", "status_pages"
    add_foreign_key "check_pings", "checks"
    add_foreign_key "team_members", "teams"
    add_foreign_key "team_members", "users"
    add_foreign_key "oauth_access_grants", "oauth_applications", column: "application_id"
    add_foreign_key "oauth_access_grants", "users", column: "resource_owner_id"
    add_foreign_key "oauth_access_tokens", "oauth_applications", column: "application_id"
    add_foreign_key "oauth_access_tokens", "users", column: "resource_owner_id"
    add_foreign_key "shifts", "alerts"
    add_foreign_key "shifts", "teams"
    add_foreign_key "shifts", "shift_openings"
    add_foreign_key "status_pages", "teams"
    add_foreign_key "status_page_subscribers", "status_pages"
    add_foreign_key "browser_pushes", "users"
  end

  def down
    raise ActiveRecord::IrreversibleMigration
  end
end
