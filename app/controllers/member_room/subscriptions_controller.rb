# frozen_string_literal: true

module MemberRoom
  class SubscriptionsController < MemberRoomController
    load_and_authorize_resource through: :current_member

    # GET /subscriptions
    # GET /subscriptions.json
    def index
      @subscriptions = current_member.subscriptions.order(subscribed_at: :desc).page
    end

    # GET /subscriptions/1
    # GET /subscriptions/1.json
    def show
      render layout: false
    end
  end
end
