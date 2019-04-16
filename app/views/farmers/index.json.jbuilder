# frozen_string_literal: true

json.array! @farmers, partial: 'farmers/farmer', as: :farmer
