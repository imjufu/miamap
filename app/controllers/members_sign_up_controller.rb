# frozen_string_literal: true

class MembersSignUpController < ApplicationController
  before_action :set_registration_request

  # GET /members_sign_up/step_1
  def step_1
    redirect_to(send("members_sign_up_step_#{@registration_request.step}_path")) if @registration_request

    @registration_request = MemberRegistrationRequest.new
  end

  # POST /members_sign_up/step_1
  def save_step_1
    @registration_request = MemberRegistrationRequest.new(step_params.merge(step: 1))

    if @registration_request.save
      session[:member_registration_identifier] = @registration_request.identifier
      redirect_to members_sign_up_step_2_path
    else
      render :step_1
    end
  end

  # GET /members_sign_up/step_2
  def step_2
  end

  # PATCH /members_sign_up/step_2
  def save_step_2
    if @registration_request.update(step_params.merge(step: 2))
      redirect_to members_sign_up_step_3_path
    else
      render :step_2
    end
  end

  # GET /members_sign_up/step_3
  def step_3
    redirect_to(members_sign_up_step_2_path) if @registration_request.step <= 1
  end

  # PATCH /members_sign_up/step_3
  def save_step_3
    if @registration_request.update(step_params.merge(step: 3))
      redirect_to members_sign_up_step_4_path
    else
      render :step_3
    end
  end

  # GET /members_sign_up/step_4
  def step_4
    redirect_to(members_sign_up_step_3_path) if @registration_request.step <= 2

    @registration_request.update(step: 4)
  end

  # DELETE /members_sign_up
  def destroy
    @registration_request.destroy
    redirect_to(members_sign_up_step_1_path)
  end

  private

  # Never trust parameters from the scary internet, only allow
  # the white list through.
  def step_params
    params.require(:member_registration_request).permit(
      :email, :step, :first_name, :last_name, :date_of_birth, :address, :postal_code, :city
    )
  end

  def set_registration_request
    @registration_request = MemberRegistrationRequest.find_by(identifier: session[:member_registration_identifier])
  end
end
