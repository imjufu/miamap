# frozen_string_literal: true

json.array! @subscriptions, partial: 'admin_room/subscriptions/subscription',
                            as: :subscription
