# frozen_string_literal: true

module Admin
  class UsersController < AdminController
    include RemoveBlankPasswordConcern

    load_and_authorize_resource

    # GET /users
    # GET /users.json
    def index
      @users = User.order(:first_name).page
    end

    # GET /users/1
    # GET /users/1.json
    def show
    end

    # GET /users/new
    def new
      @user = User.new
    end

    # GET /users/1/edit
    def edit
    end

    # POST /users
    # POST /users.json
    def create
      @user = User.new(user_params)

      respond_to do |format|
        if @user.save
          format.html { redirect_to admin_user_path(@user), notice: t('.created') }
          format.json { render :show, status: :created, location: @user }
        else
          format.html { render :new }
          format.json { render json: @user.errors, status: :unprocessable_entity }
        end
      end
    end

    # PATCH/PUT /users/1
    # PATCH/PUT /users/1.json
    def update
      remove_blank_password_for(:user)

      respond_to do |format|
        if @user.update(user_params)
          format.html { redirect_to admin_user_path(@user), notice: t('.updated') }
          format.json { render :show, status: :ok, location: @user }
        else
          format.html { render :edit }
          format.json { render json: @user.errors, status: :unprocessable_entity }
        end
      end
    end

    # DELETE /users/1
    # DELETE /users/1.json
    def destroy
      @user.destroy
      respond_to do |format|
        format.html { redirect_to admin_users_url, notice: t('.destroyed') }
        format.json { head :no_content }
      end
    end

    private

    # Never trust parameters from the scary internet, only allow the
    # white list through.
    def user_params
      params.require(:user).permit(:email, :first_name, :last_name, :password)
    end
  end
end
