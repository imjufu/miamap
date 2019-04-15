# frozen_string_literal: true

module ApplicationHelper
  def humanize_dt(datetime)
    l(datetime) if datetime.present?
  end
end
