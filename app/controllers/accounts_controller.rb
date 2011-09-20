class AccountsController < ApplicationController
  respond_to :html

  def edit
    debugger
    @user = current_user
  end
end