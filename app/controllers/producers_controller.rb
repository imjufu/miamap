# frozen_string_literal: true

class ProducersController < ApplicationController
  load_and_authorize_resource

  # GET /producers
  # GET /producers.json
  def index
    @producers = Producer.order(:name).page
  end

  # GET /producers/1
  # GET /producers/1.json
  def show
  end

  # GET /producers/new
  def new
    @producer = Producer.new
  end

  # GET /producers/1/edit
  def edit
  end

  # POST /producers
  # POST /producers.json
  def create
    @producer = Producer.new(producer_params)

    respond_to do |format|
      if @producer.save
        format.html { redirect_to @producer, notice: t('.created') }
        format.json { render :show, status: :created, location: @producer }
      else
        format.html { render :new }
        format.json { render json: @producer.errors, status: :unprocessable_entity } # rubocop:disable Metrics/LineLength
      end
    end
  end

  # PATCH/PUT /producers/1
  # PATCH/PUT /producers/1.json
  def update
    respond_to do |format|
      if @producer.update(producer_params)
        format.html { redirect_to @producer, notice: t('.updated') }
        format.json { render :show, status: :ok, location: @producer }
      else
        format.html { render :edit }
        format.json { render json: @producer.errors, status: :unprocessable_entity } # rubocop:disable Metrics/LineLength
      end
    end
  end

  # DELETE /producers/1
  # DELETE /producers/1.json
  def destroy
    @producer.destroy
    respond_to do |format|
      format.html { redirect_to producers_url, notice: t('.destroyed') }
      format.json { head :no_content }
    end
  end

  private

  # Never trust parameters from the scary internet, only allow
  # the white list through.
  def producer_params
    params.require(:producer).permit(
      :name, :email_address, :address, :postal_code, :city
    )
  end
end
