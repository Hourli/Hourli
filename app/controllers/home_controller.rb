class HomeController < ApplicationController
  skip_before_action :authenticate_user!

  #leading to dashboard according to the role
  def index
    if user_signed_in?
      if current_user.role == "customer"
        redirect_to customer_dashboard_path
      elsif current_user.role == "contractor"
        redirect_to contractors_path
      end
    else
      render :index
    end
  end

  def contact
  end

  def about
  end
end
