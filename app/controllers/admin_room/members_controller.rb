# frozen_string_literal: true

module AdminRoom
  class MembersController < AdminController
    include RemoveBlankPasswordConcern

    load_and_authorize_resource

    # GET /members
    # GET /members.json
    def index
      query = params[:q]

      @members = if query.present?
                   Member.ransack(name_cont: query).result(distinct: true).page
                 else
                   Member.order(:first_name).page
                 end
    end

    # GET /members/1
    # GET /members/1.json
    def show
    end

    # GET /members/new
    def new
      @member = Member.new
    end

    # GET /members/1/edit
    def edit
    end

    # POST /members
    # POST /members.json
    def create
      @member = Member.new(member_params)

      respond_to do |format|
        if @member.save
          format.html { redirect_to admin_room_member_path(@member), notice: t('.created') }
          format.json { render :show, status: :created, location: @member }
        else
          format.html { render :new }
          format.json { render json: @member.errors, status: :unprocessable_entity }
        end
      end
    end

    # PATCH/PUT /members/1
    # PATCH/PUT /members/1.json
    def update
      remove_blank_password_for(:member)

      respond_to do |format|
        if @member.update(member_params)
          format.html { redirect_to admin_room_member_path(@member), notice: t('.updated') }
          format.json { render :show, status: :ok, location: @member }
        else
          format.html { render :edit }
          format.json { render json: @member.errors, status: :unprocessable_entity }
        end
      end
    end

    # DELETE /members/1
    # DELETE /members/1.json
    def destroy
      @member.destroy
      respond_to do |format|
        format.html { redirect_to admin_room_members_url, notice: t('.destroyed') }
        format.json { head :no_content }
      end
    end

    private

    # Never trust parameters from the scary internet, only allow
    # the white list through.
    def member_params
      params.require(:member).permit(
        :first_name, :last_name, :email, :address, :postal_code,
        :city, :date_of_birth, :password
      )
    end
  end
end
