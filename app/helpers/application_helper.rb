module ApplicationHelper
	# Return the full title of page
	def full_title(page_title)
		base_title = "Kappa Delta"
		if page_title.empty?
			return base_title
		else
			return "#{base_title} | #{page_title}"
		end
	end

	# Returns the navigation link with the current class
	def nav_link(link_text, link_path)
		class_name = current_page?(link_path) ? 'current' : ''
		link_to link_text, link_path, class: class_name
	end

	# Return the back button
	def back_button(url)
		link_to "&#8592; Back".html_safe, url, id: :back
	end
end
