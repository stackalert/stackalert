# frozen_string_literal: true

class ArrayOfDaysValidator < ActiveModel::EachValidator
  def validate_each(record, attribute, value)
    if value.blank? || value.all?(&:blank?)
      record.errors.add(attribute, 'is blank')
      return
    end

    valid = value.all? { |day| Date::DAYNAMES.include?(day) }
    record.errors.add(attribute, 'is not valid') unless valid
  end
end
