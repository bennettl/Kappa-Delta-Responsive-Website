Forem.user_class = "Member"
Forem.email_from_address = "please-change-me@example.com"
# If you do not want to use gravatar for avatars then specify the method to use here:
# Forem.avatar_user_method = :custom_avatar_url
Forem.per_page = 20
Forem.sign_in_path = "/signin/"

Rails.application.config.to_prepare do
#   If you want to change the layout that Forem uses, uncomment and customize the next line:
	# wrapping forum and admin area in application layout
	Forem::ApplicationController.layout "application"
	Forem::Admin::BaseController.layout "application"
	Forem.moderate_first_post = false
#   If you want to add your own cancan Abilities to Forem, uncomment and customize the next line:
#   Forem::Ability.register_ability(Ability)
end

#
# By default, these lines will use the layout located at app/views/layouts/forem.html.erb in your application.
