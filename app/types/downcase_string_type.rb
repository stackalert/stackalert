# frozen_string_literal: true

class DowncaseStringType < ActiveRecord::Type::String
  def cast(value)
    super.try(:downcase)
  end
end
