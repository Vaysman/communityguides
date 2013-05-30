class Users::RegistrationsController < Devise::RegistrationsController
	before_filter :get_countries

	def update
		# no mass update for country_id, we do it manually
		# check for existence of country in case a malicious user manipulates the params (fails silently)
		if params[resource_name][:country_id]          
   	 resource.country_id = params[resource_name][:country_id] if Country.find_by_id(params[resource_name][:country_id])
  	end
  	super
	end
private
	def get_countries
		@all_countries = Country.all
		@countries = []
		@all_countries.each do |c|
			@countries.push([c.name, c.id])
		end
	end
end