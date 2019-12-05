# frozen_string_literal: true

require 'rotp'

class UsersController < ApplicationController
  before_action :set_user, only: [ :second_factor, :second_factor_setup ]
  #before_action :second_factor, only: :create

  # GET /users/new
  def new
    @user = User.new
  end

  # POST /users
  # POST /users.json
  def create
    secret_key = ROTP::Base32.random
    @user = User.new(user_params.merge( { secret_key: secret_key }))
    respond_to do |format|
      if @user.save
        #raise 111
        format.html { redirect_to second_factor_path(@user)}
        format.json { render :show, status: :created, location: @user }
      else
        format.html { render :new }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  def second_factor
    totp = ROTP::TOTP.new(@user.secret_key)
    str = totp.provisioning_uri(@user.email)
    @qrcode = RQRCode::QRCode.new(str, :size => 6, :level => :q )
  end

  def second_factor_setup
    totp = ROTP::TOTP.new(@user.secret_key)
    respond_to do |format|
      if totp.verify(params[:confirmation_code])
        format.html { redirect_to root_path, notice: 'User was successfully created.' }
      else
        @user.delete
        format.html { redirect_to signup_path, alert: 'Confirmation code is wrong, please sign up' }
      end
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def user_params
      params.require(:user).permit(:email, :password, :password_confirmation, :confirmation_code)
    end
end
