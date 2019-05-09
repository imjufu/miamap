# frozen_string_literal: true

json.array! @membership_forms, partial: 'membership_forms/membership_form',
                               as: :membership_form
