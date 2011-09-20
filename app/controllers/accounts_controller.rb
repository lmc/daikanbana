class AccountsController < ApplicationController
  respond_to :html

  def edit
    @user = current_user
  end
end