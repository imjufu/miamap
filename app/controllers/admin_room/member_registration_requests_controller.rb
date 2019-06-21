# frozen_string_literal: true

module AdminRoom
  class MemberRegistrationRequestsController < AdminController
    load_and_authorize_resource

    # GET /member_registration_requests
    # GET /member_registration_requests.json
    def index
      @member_registration_requests = MemberRegistrationRequest.order(:created_at).page
    end

    # GET /member_registration_requests/1
    # GET /member_registration_requests/1.json
    def show
    end
  end
end
