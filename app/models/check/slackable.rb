# frozen_string_literal: true

class Check
  module Slackable
    extend ActiveSupport::Concern
    def slack_attachment
      {
        fallback: "#{ping_state} *#{name}* - #{endpoint}",
        title: name,
        text: endpoint,
        color: slack_color,
        callback_id: "check_#{id}",
        actions: [
          {
            name: 'detail',
            text: 'Detail',
            type: 'button',
            value: id
          }
        ]
      }
    end

    def slack_attachment_detail
      {
        fallback: "#{ping_state} *#{name}* - #{endpoint}",
        title: name,
        color: slack_color,
        image_url: Rails.application.routes.url_helpers.url_for(charts.last),
        fields: [
          {
            title: 'Danger Threshold',
            value: "#{danger_threshold}ms",
            short: true
          },
          {
            title: 'Warning Threshold',
            value: "#{warning_threshold}ms",
            short: true
          },
          {
            title: 'URL',
            value: endpoint,
            short: true
          }
        ]
      }
    end

    private

    def slack_color
      case ping_state
      when 'success' then '#5cb85c'
      when 'warning' then '#F0AD4E'
      when 'danger' then '#D9534F'
      end
    end
  end
end
