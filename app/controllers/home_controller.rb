class HomeController < ApplicationController
  skip_before_action :authenticate_user!

  #leading to dashboard according to the role
  def index
    if current_user.role == "customer"
      redirect_to customers_path
    else current_user.role == "contractor"
      redirect_to contractors_path
    end
  end

  def contact
  end

  def about
  end
end
