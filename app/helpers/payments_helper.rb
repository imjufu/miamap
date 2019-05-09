# frozen_string_literal: true

module PaymentsHelper
  def humanize_payment_means(mean)
    t("payments.means.#{mean}")
  end
end
