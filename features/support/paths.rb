module NavigationHelpers

	def path_to(page_name)
		case page_name
		when "home"
			root_path

		when "contact us"
			contact_path
			
		when "New Job"
			new_job_path
		
		when "create job"
			job_path

		when "about us"
			about_us_path
		end
	end
end
	World(NavigationHelpers)
