# frozen_string_literal: true

class SlackTeam
  module Remotable
    extend ActiveSupport::Concern

    def save_remote(channel, text, attachments)
      client.chat_postMessage(channel: channel,
                              text: text,
                              attachments: attachments,
                              as_user: true)
    end

    def channels
      Rails.cache.fetch("#{cache_key}/channels", expires_in: 60.minutes) do
        client.channels_list.channels.map(&:name)
      end
    end

    private

    def client
      @client ||= Slack::Web::Client.new(token: token)
    end
  end
end
