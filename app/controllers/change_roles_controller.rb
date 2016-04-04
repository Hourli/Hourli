class ChangeRolesController < ApplicationController
  def change_role
    respond_to do |format|
      format.json {
        status = :ok
        errors = []
        if current_user.customer and current_user.contractor
          if params[:new_role].in? ['customer', 'contractor']
            current_user.role = params[:new_role]
            current_user.save
          else
            errors = "#{params[:new_role]} is not a valid role"
            status =  :bad_request
          end
        else
          if current_user.customer
            errors = "#{current_user.email} does not have a valid contractor"
          elsif current_user.contractor
            errors = "#{current_user.email} does not have a valid customer"
          else
            errors = "#{current_user.email} does not have a valid customer or contractor"
          end
          status = :bad_request
        end
        render json: errors.empty? ? {} : {'errors': errors}, status: status
      }
    end
  end
end
