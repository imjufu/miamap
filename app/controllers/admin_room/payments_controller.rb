# frozen_string_literal: true

module AdminRoom
  class PaymentsController < AdminRoomController
    load_and_authorize_resource :subscription
    load_and_authorize_resource :payment, through: :subscription

    # GET /subscriptions/1/payments/1
    # GET /subscriptions/1/payments/1.json
    def show
    end

    # GET /subscriptions/1/payments/new
    def new
      @payment = Payment.new
    end

    # GET /subscriptions/1/payments/1/edit
    def edit
    end

    # POST /subscriptions/1/payments
    # POST /subscriptions/1/payments.json
    def create
      @payment = Payment.new(payment_params.merge(subscription: @subscription))

      respond_to do |format|
        if @payment.save
          format.html { redirect_to admin_room_subscription_payment_path(id: @payment.id, subscription_id: @subscription.id), notice: t('.created') }
          format.json { render :show, status: :created }
        else
          format.html { render :new }
          format.json { render json: @payment.errors, status: :unprocessable_entity }
        end
      end
    end

    # PATCH/PUT /subscriptions/1/payments/1
    # PATCH/PUT /subscriptions/1/payments/1.json
    def update
      respond_to do |format|
        if @payment.update(payment_params)
          format.html { redirect_to admin_room_subscription_payment_path(id: @payment.id, subscription_id: @subscription.id), notice: t('.updated') }
          format.json { render :show, status: :ok }
        else
          format.html { render :edit }
          format.json { render json: @payment.errors, status: :unprocessable_entity }
        end
      end
    end

    # DELETE /subscriptions/1/payments/1
    # DELETE /subscriptions/1/payments/1.json
    def destroy
      @payment.destroy
      respond_to do |format|
        format.html { redirect_to admin_room_subscription_path(@subscription), notice: t('.destroyed') }
        format.json { head :no_content }
      end
    end

    private

    # Never trust parameters from the scary internet,
    # only allow the white list through.
    def payment_params
      params.require(:payment).permit(:payed_at, :amount, :means)
    end
  end
end
