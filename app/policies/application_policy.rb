# frozen_string_literal: true

class ApplicationPolicy
  attr_reader :current, :record

  def initialize(current, record)
    @current = current
    @record = record
  end

  def new?
    @new ||= current.user.has_role?('Writer', current.team)
  end

  alias create? new?
  alias edit? new?
  alias update? new?
  alias destroy? new?
end
