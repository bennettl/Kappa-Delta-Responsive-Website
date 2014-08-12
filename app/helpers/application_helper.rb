module ApplicationHelper
	# Use for bootsy
	def refresh_btn
		""
	end

	# Return the full title of page
	def full_title(page_title)
		base_title = "Kappa Delta"
		if page_title.empty?
			return base_title
		else
			return "#{base_title} | #{page_title}"
		end
	end

	def search_column(placeholder, name = nil, value, classes)
		name 			||= placeholder
		css_class 		= (params[:sort] == name) ? "#{params[:direction]}" : "asc"; 
		# If sort query is for this colum and direction is asc, have a link to desc
		direction 		= (params[:sort] == name && params[:direction] == 'asc') ? 'desc' : 'asc'
		page 			= params[:page]
		major 			= params[:major]
		first_name 		= params[:first_name]

		text_field_tag name, value, placeholder: placeholder, data: {column_type: name}, class: "search_column form-control #{classes}" 
		# link_to name, {sort: name, direction: direction, page: page, first_name: first_name, major: major, remote: true}, {class: css_class}
	end

	# Returns the navigation link with the current class
	def nav_link(link_text, link_path)
		class_name = current_page?(link_path) ? 'current' : ''
		link_to link_text, link_path, class: class_name
	end

	# Returns a back button with the path specified
	def back_button path
		link_to 'Back', path , class: 'button pull-left', style: "margin-bottom: 15px"
	end

	def forem_back_button(forum)
	   if @topic 
	       link_to t('forem.topic.links.back_to_topics'), forem.forum_path(forum), :class => "button pull-left"
	    end
	end

	# Returns a new button
	def new_button text, path
		link_to text, path, class: 'button', id: 'new-sm'
	end

	# Returns an edit button
	def edit_button text, path
		link_to text, path, class: 'button pull-right'
	end

end
