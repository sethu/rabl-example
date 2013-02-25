class HomeController < ApplicationController
  def index
    if user_signed_in?
      tasks_path
    else
      redirect_to new_user_registration_path
    end
  end
end
