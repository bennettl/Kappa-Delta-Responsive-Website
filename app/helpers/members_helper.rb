module MembersHelper

	# Use for edit and new
	def row(label, input)
		"<div class=\"group row\">
			<div class=\"col-md-4 col-sm-5\">
				#{label}
			</div>
			<div class=\"col-md-8 col-sm-7\">
				#{input}
			</div>
		</div>".html_safe
	end
end
