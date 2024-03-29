class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :destroy]
  before_action :signed_in_user, only: [:index, :edit, :update, :destroy]
  before_action :correct_user, only: [:edit, :update]
  before_action :admin_user, only: :destroy
  # GET /users
  # GET /users.json
  def index
    @users = User.paginate(page: params[:page])
  end

  # GET /users/1
  # GET /users/1.json
  def show
    @user = User.find(params[:id])
    @microposts = @user.microposts.paginate(page: params[:page])
  end
  # GET /users/new
  def new
    @user = User.new
  end

  # GET /users/1/edit
  def edit
    @user = User.find(params[:id])
  end

  # POST /users
  # POST /users.json
  def create
    @user = User.new(user_params)
      respond_to do |format|
        if @user.save
          sign_in @user
          flash[:success] = "Welcome to the Sample App!" 
          format.html { redirect_to @user, notice: 'user was successfully created.' }
          format.json { head :no_content }   
        else
          format.html { render action: 'new' }
          format.json { render json: @user.errors, status: :unprocessable_entity }
        end
      end
  end    
  # PATCH/PUT /users/1
  # PATCH/PUT /users/1.json
  def update
    @user = User.find(params[:id])
      respond_to do |format|
        if @user.update_attributes(user_params)
          flash[:success] = "Profile updated"
          format.html { redirect_to @user, notice: 'User was successfully updated.' }
          format.json { head :no_content }
        else
          format.html { render action: 'edit' }
          format.json { render json: @user.errors, status: :unprocessable_entity }
        end
      end
  end    
  # DELETE /users/1
  # DELETE /users/1.json
  def destroy
    User.find(params[:id]).destroy
    flash[:success] = "User deleted."
    respond_to do |format|
      format.html { redirect_to users_url }
      format.json { head :no_content }
    end 
  end

    # Use callbacks to share common setup or constraints between actions.
  def correct_user
    @user = User.find(params[:id])
      respond_to do |format|
        format.html { redirect_to(root_url) unless current_user?(@user) }
        format.json { head :no_content }
      end
  end

  private

    def set_user
      @user = User.find(params[:id])
    end

    def user_params
      params.require(:user).permit(:name, :email,:password, :password_confirmation ,:image )
    end

    def admin_user
      respond_to do |format|
        format.html { redirect_to(root_url) unless current_user.admin? }
      end
    end
end