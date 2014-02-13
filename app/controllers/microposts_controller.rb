class MicropostsController < ApplicationController
	before_action :signed_in_user, only: [:create, :destroy]
	def create
		@micropost = current_user.micropost.build(micropost_params)
		if @micropost.save
			flash[:success] = "Micropost created!"
			redirect_to root_url
		else
			render action: 'static/home'	
		end		
	end

	def destroy
		
	end
	private 
	def micropost_params
		params.require(:micropost).permit(:content)
	end
end