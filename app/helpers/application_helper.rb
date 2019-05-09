# frozen_string_literal: true

module ApplicationHelper
  def humanize_dt(datetime, format: :short)
    l(datetime, format: format) if datetime.present?
  end

  def humanize_bool(bool)
    if bool
      tag('i', class: 'fas fa-check text-success')
    else
      tag('i', class: 'fas fa-times text-danger')
    end
  end
end
