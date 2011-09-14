class RegistrationsController < ApplicationController
  respond_to :html

  def new
    @user = User.new
    respond_with(@user)
  end

  def create
    @user = User.new(params[:user])
    @user.register #calls .save, failures handled with respond_with
    respond_with(@user,:location => root_path)
  end
end