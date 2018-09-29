# frozen_string_literal: true

module ShiftHelper
  def shift_border(shift)
    if shift.in_progress?
      'border-danger'
    elsif shift.today?
      'border-warning'
    else
      'border-success'
    end
  end

  def shift_icon(shift)
    if shift.in_progress?
      'phone'
    elsif shift.today?
      'pause'
    else
      'stop'
    end
  end

  def shift_color(shift)
    if shift.in_progress?
      'text-danger'
    elsif shift.today?
      'text-warning'
    else
      'text-muted'
    end
  end
end
