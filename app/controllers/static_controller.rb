class StaticController < ApplicationController
	def home
		@micropost = current_user.microposts.build if signed_in?
	end
end