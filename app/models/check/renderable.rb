# frozen_string_literal: true

class Check
  module Renderable
    extend ActiveSupport::Concern

    def render
      ApplicationController.renderer.render(partial: 'teams/checks/check', locals: { check: self })
    end
  end
end
