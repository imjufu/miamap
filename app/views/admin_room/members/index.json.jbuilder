# frozen_string_literal: true

json.array! @members, partial: 'admin_room/members/member', as: :member
