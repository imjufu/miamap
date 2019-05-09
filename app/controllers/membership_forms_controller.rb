# frozen_string_literal: true

class MembershipFormsController < ApplicationController
  load_and_authorize_resource

  # GET /membership_forms
  # GET /membership_forms.json
  def index
    @membership_forms = MembershipForm.order(:title).page
  end

  # GET /membership_forms/1
  # GET /membership_forms/1.json
  def show
  end

  # GET /membership_forms/new
  def new
    @membership_form = MembershipForm.new
  end

  # GET /membership_forms/1/edit
  def edit
  end

  # POST /membership_forms
  # POST /membership_forms.json
  def create
    @membership_form = MembershipForm.new(membership_form_params)

    respond_to do |format|
      if @membership_form.save
        format.html { redirect_to @membership_form, notice: t('.created') }
        format.json { render :show, status: :created, location: @membership_form } # rubocop:disable Metrics/LineLength
      else
        format.html { render :new }
        format.json { render json: @membership_form.errors, status: :unprocessable_entity } # rubocop:disable Metrics/LineLength
      end
    end
  end

  # PATCH/PUT /membership_forms/1
  # PATCH/PUT /membership_forms/1.json
  def update
    respond_to do |format|
      if @membership_form.update(membership_form_params)
        format.html { redirect_to @membership_form, notice: t('.updated') }
        format.json { render :show, status: :ok, location: @membership_form }
      else
        format.html { render :edit }
        format.json { render json: @membership_form.errors, status: :unprocessable_entity } # rubocop:disable Metrics/LineLength
      end
    end
  end

  # DELETE /membership_forms/1
  # DELETE /membership_forms/1.json
  def destroy
    @membership_form.destroy
    respond_to do |format|
      format.html { redirect_to membership_forms_url, notice: t('.destroyed') }
      format.json { head :no_content }
    end
  end

  private

  # Never trust parameters from the scary internet,
  # only allow the white list through.
  def membership_form_params
    params.require(:membership_form).permit(:title, :content)
  end
end
