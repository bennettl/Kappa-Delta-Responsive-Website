module MembersHelper
	def search_column(placeholder, name = nil, value)
		name 			||= placeholder
		css_class 		= (params[:sort] == name) ? "#{params[:direction]}" : "asc"; 
		# If sort query is for this colum and direction is asc, have a link to desc
		direction 		= (params[:sort] == name && params[:direction] == 'asc') ? 'desc' : 'asc'
		page 			= params[:page]
		major 			= params[:major]
		first_name 		= params[:first_name]

		text_field_tag name, value, placeholder: placeholder, data: {column_type: name}, class: :search_column
		# link_to name, {sort: name, direction: direction, page: page, first_name: first_name, major: major, remote: true}, {class: css_class}
	end
end
