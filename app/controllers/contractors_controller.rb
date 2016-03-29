class ContractorsController < ApplicationController
	def create
		current_user.contractor = Contractor.create()
		redirect_to edit_user_registration_path
	end
end
