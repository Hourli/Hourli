module NavigationHelpers

	def path_to(page_name)
		case page_name
			when "home"
				root_path

			when "contact us"
				contact_path

		    when /^details for '(.*)' $/
				edit_job_request_path(JobRequest.find_by_title($1))

			when "New Job"
				new_job_path

			when "Jobs"
				jobs_path

			when "new job request"
				new_job_request_path

			when "job request"
				job_request_path

			when "create job"
				job_path

			when "about us"
				about_us_path

			when "sign up"
				new_user_registration_path

			when "customer_dashboard"
				customers_path

			when "contractor_dashboard"
				contractors_path

			when "edit user"
				edit_user_registration_path

			when "notifications_index"
				notifications_path
		end
	end
end
World(NavigationHelpers)
