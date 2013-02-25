class RegistrationsController < Devise::RegistrationsController
  
  def create
    respond_to do |format|
      format.html {super}
      format.json{
        if params[:api_key].blank? or params[:api_key] != API_KEY
          render :json => {'errors'=>{'api_key' => 'Invalid'}}.to_json, :status => 401
          return
        end
        puts params[:user]
        puts params["user"]
        puts params
        build_resource
        if resource.save
          sign_in(resource)
          resource.reset_authentication_token!
          render :template => '/devise/registrations/signed_up'
        else
          
          p resource.errors
          render :template => '/devise/registrations/new'
        end
      }
    end
  end
end
