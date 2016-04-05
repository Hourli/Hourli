class ChangeRolesController < ApplicationController
  def change_role
    respond_to do |format|
      format.js {
        status = :ok
        if not current_user.customer.nil? and not current_user.contractor.nil?
          current_user.role = (current_user.role == 'contractor') ? 'customer' : 'contractor'
          current_user.save
        else
          status = :bad_request
        end
        render :change_role, status: status
      }
    end
  end
end
