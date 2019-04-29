# frozen_string_literal: true

class SubscriptionsController < ApplicationController
  load_and_authorize_resource

  # GET /subscriptions
  # GET /subscriptions.json
  def index
    @subscriptions = Subscription.order(:subscribed_at).page
  end

  # GET /subscriptions/1
  # GET /subscriptions/1.json
  def show
  end

  # GET /subscriptions/new
  def new
    @subscription = Subscription.new(subscribed_at: Time.now.in_time_zone)
  end

  # POST /subscriptions
  # POST /subscriptions.json
  def create
    @subscription = Subscription.new(subscription_params)

    respond_to do |format|
      if @subscription.save
        format.html { redirect_to @subscription, notice: t('.created') }
        format.json { render :show, status: :created, location: @subscription }
      else
        format.html { render :new }
        format.json { render json: @subscription.errors, status: :unprocessable_entity } # rubocop:disable Metrics/LineLength
      end
    end
  end

  # PATCH/PUT /subscriptions/1
  # PATCH/PUT /subscriptions/1.json
  def update
    respond_to do |format|
      if @subscription.update(subscription_params)
        format.html { redirect_to @subscription, notice: t('.updated') }
        format.json { render :show, status: :ok, location: @subscription }
      else
        format.html { render :edit }
        format.json { render json: @subscription.errors, status: :unprocessable_entity } # rubocop:disable Metrics/LineLength
      end
    end
  end

  # DELETE /subscriptions/1
  # DELETE /subscriptions/1.json
  def destroy
    @subscription.destroy
    respond_to do |format|
      format.html { redirect_to subscriptions_url, notice: t('.destroyed') }
      format.json { head :no_content }
    end
  end

  # GET /subscriptions/1/preview
  def preview
    render layout: false
  end

  private

  # Never trust parameters from the scary internet, only allow
  # the white list through.
  def subscription_params
    params.require(:subscription).permit(
      :member_id, :contract_id, :subscribed_at
    )
  end
end
