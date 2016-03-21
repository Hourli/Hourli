module NavigationHelpers

   def path_to(page_name)
      case page_name
	  when "home"
	     root_path

	  when "contact us"
		contact_path
	  end
   end
end
World(NavigationHelpers)
