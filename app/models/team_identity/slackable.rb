# frozen_string_literal: true

class TeamIdentity
  module Slackable
    extend ActiveSupport::Concern

    def slack?
      provider == 'slack'
    end

    def slack_receive(event)
      text, attachments = *EventMessage.new(self, event).generate
      slack_push(event[:channel], text, attachments) if text.present?
    end

    def slack_action(payload)
      check = find_check(payload)
      return if check.nil?
      text, attachments = *EventMessage::Check.new(check).generate
      slack_push(payload['channel']['id'], text, attachments)
    end

    def slack_push(channel, text, attachments)
      slack_client.chat_postMessage(channel: channel,
                                    text: text,
                                    attachments: attachments,
                                    as_user: true)
    end

    def slack_channels
      Rails.cache.fetch("#{cache_key}/channels", expires_in: 60.minutes) do
        slack_client.channels_list.channels.map(&:name)
      end
    end

    private

    def find_check(payload)
      Check.find_by id: payload['actions'].first['value']
    end

    def slack_client
      @slack_client ||= Slack::Web::Client.new(token: oauth_token)
    end
  end
end
