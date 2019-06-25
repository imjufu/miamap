# frozen_string_literal: true

module AdminRoom
  class MemberRegistrationRequestsController < AdminRoomController
    load_and_authorize_resource

    # GET /member_registration_requests
    # GET /member_registration_requests.json
    def index
      @member_registration_requests = MemberRegistrationRequest.not_accepted_or_refused_yet
                                                               .order(created_at: :desc)
                                                               .page
    end

    # GET /member_registration_requests/1
    # GET /member_registration_requests/1.json
    def show
    end

    # PUT /member_registration_requests/1/accept
    # PUT /member_registration_requests/1/accept.json
    def accept # rubocop:disable Metrics/MethodLength
      respond_to do |format|
        if @member_registration_request.accept(user: current_user)
          format.html { redirect_to admin_room_member_registration_request_path(id: @member_registration_request.id), notice: t('.accepted') }
          format.json { render :show, status: :ok, location: @member_registration_request }
        else
          format.html do
            flash[:alert] = @member_registration_request.errors.full_messages.join(', ')
            render :show
          end
          format.json { render json: @member_registration_request.errors, status: :unprocessable_entity }
        end
      end
    end

    # PUT /member_registration_requests/1/refuse
    # PUT /member_registration_requests/1/refuse.json
    def refuse # rubocop:disable Metrics/MethodLength
      respond_to do |format|
        if @member_registration_request.refuse(user: current_user)
          format.html { redirect_to admin_room_member_registration_request_path(id: @member_registration_request.id), notice: t('.refused') }
          format.json { render :show, status: :ok, location: @member_registration_request }
        else
          format.html do
            flash[:alert] = @member_registration_request.errors.full_messages.join(', ')
            render :show
          end
          format.json { render json: @member_registration_request.errors, status: :unprocessable_entity }
        end
      end
    end
  end
end
