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
end
