class RegistrationsController < Devise::RegistrationsController
  inherit_resources
  defaults :resource_class => User, :collection_name => 'users', :instance_name => 'user'
  actions :new, :create

  respond_to :html


  create! do |success,failure|
    success.html do
      sign_in(@user)
      redirect_to edit_account_path
    end
  end
  

  protected

  def create_resource(user)
    user.register #calls .save, failures handled by 
  end
end