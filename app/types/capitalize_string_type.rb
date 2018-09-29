# frozen_string_literal: true

class CapitalizeStringType < ActiveRecord::Type::String
  def cast(value)
    super.try(:capitalize)
  end
end
