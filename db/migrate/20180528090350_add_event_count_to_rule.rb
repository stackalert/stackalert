class AddEventCountToRule < ActiveRecord::Migration[5.2]
  def change
    add_column :alert_rules, :alert_events_count, :integer, default: 0, null: false
  end
end
