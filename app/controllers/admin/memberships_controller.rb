# frozen_string_literal: true

module Admin
  class MembershipsController < AdminController
    load_and_authorize_resource :member
    load_and_authorize_resource :membership, through: :member

    # GET /members/1/memberships/1
    # GET /members/1/memberships/1.json
    def show
    end

    # GET /members/1/memberships/new
    def new
      @membership = Membership.new
    end

    # GET /members/1/memberships/1/edit
    def edit
    end

    # POST /members/1/memberships
    # POST /members/1/memberships.json
    def create
      @membership = Membership.new(membership_params.merge(member: @member))

      respond_to do |format|
        if @membership.save
          format.html { redirect_to admin_member_membership_path(id: @membership.id, member_id: @member.id), notice: t('.created') }
          format.json { render :show, status: :created, location: @membership }
        else
          format.html { render :new }
          format.json { render json: @membership.errors, status: :unprocessable_entity }
        end
      end
    end

    # PATCH/PUT /members/1/memberships/1
    # PATCH/PUT /members/1/memberships/1.json
    def update
      respond_to do |format|
        if @membership.update(membership_params)
          format.html { redirect_to admin_member_membership_path(id: @membership.id, member_id: @member.id), notice: t('.updated') }
          format.json { render :show, status: :ok, location: @membership }
        else
          format.html { render :edit }
          format.json { render json: @membership.errors, status: :unprocessable_entity }
        end
      end
    end

    # DELETE /members/1/memberships/1
    # DELETE /members/1/memberships/1.json
    def destroy
      @membership.destroy
      respond_to do |format|
        format.html { redirect_to admin_member_path(@member), notice: t('.destroyed') }
        format.json { head :no_content }
      end
    end

    private

    # Never trust parameters from the scary internet,
    # only allow the white list through.
    def membership_params
      params.require(:membership).permit(:membershiped_at, :membership_form_id)
    end
  end
end
