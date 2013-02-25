class SessionsController < Devise::SessionsController
  before_filter :authenticate_user!, :only => [:destroy]

  def create
    respond_to do |format|
      format.json{
        if !params[:api_key].blank? and params[:api_key] == API_KEY
          resource = warden.authenticate!(:scope => resource_name, :recall => "#{controller_path}#new")
          sign_in(resource_name, resource)
          current_user.reset_authentication_token!
          respond_with resource, :location => after_sign_in_path_for(resource)
        else
          render :json => {'errors'=>{'api_key' => 'Invalid'}}.to_json, :status => 401
        end
      }
      format.html{
        super
      }
    end
  end
  
  def destroy
    current_user.authentication_token = nil
    current_user.save
    super
  end
end
