module NavigationHelpers

	def path_to(page_name)
		case page_name
		when "home"
			root_path

		when "contact us"
			contact_path


		when "about us"
			about_us_path
		end
	end
end
	World(NavigationHelpers)
