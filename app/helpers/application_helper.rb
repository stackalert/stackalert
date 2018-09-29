# frozen_string_literal: true

module ApplicationHelper
  def bootstrap_class_for(flash_type)
    case flash_type.to_sym
    when :alert
      'alert-danger'
    when :notice
      'alert-success'
    else
      flash_type.to_s
    end
  end

  def avatar_url(source, default:)
    avatar = source.send(:avatar)
    avatar.attached? ? url_for(avatar) : default
  end
end
