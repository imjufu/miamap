# frozen_string_literal: true

class ContractsController < ApplicationController
  load_and_authorize_resource :farmer
  load_and_authorize_resource :contract, through: :farmer

  # GET /farmers/1/contracts/1
  # GET /farmers/1/contracts/1.json
  def show
  end

  # GET /farmers/1/contracts/new
  def new
    @contract = Contract.new
  end

  # GET /farmers/1/contracts/1/edit
  def edit
  end

  # POST /farmers/1/contracts
  # POST /farmers/1/contracts.json
  def create
    @contract = Contract.new(contract_params.merge(farmer: @farmer))

    respond_to do |format|
      if @contract.save
        format.html { redirect_to farmer_contract_path(id: @contract.id, farmer_id: @farmer.id), notice: t('.created') } # rubocop:disable Metrics/LineLength
        format.json { render :show, status: :created, location: @contract }
      else
        format.html { render :new }
        format.json { render json: @contract.errors, status: :unprocessable_entity } # rubocop:disable Metrics/LineLength
      end
    end
  end

  # PATCH/PUT /farmers/1/contracts/1
  # PATCH/PUT /farmers/1/contracts/1.json
  def update
    respond_to do |format|
      if @contract.update(contract_params)
        format.html { redirect_to farmer_contract_path(id: @contract.id, farmer_id: @farmer.id), notice: t('.updated') } # rubocop:disable Metrics/LineLength
        format.json { render :show, status: :ok, location: @contract }
      else
        format.html { render :edit }
        format.json { render json: @contract.errors, status: :unprocessable_entity } # rubocop:disable Metrics/LineLength
      end
    end
  end

  # DELETE /farmers/1/contracts/1
  # DELETE /farmers/1/contracts/1.json
  def destroy
    @contract.destroy
    respond_to do |format|
      format.html { redirect_to @farmer, notice: t('.destroyed') }
      format.json { head :no_content }
    end
  end

  private

  # Never trust parameters from the scary internet, only allow
  # the white list through.
  def contract_params
    params.require(:contract).permit(:title, :content)
  end
end
