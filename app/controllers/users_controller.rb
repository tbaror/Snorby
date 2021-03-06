class UsersController < ApplicationController
  before_filter :require_user, :only => [:show, :edit, :update]
  before_filter :require_admin, :only => [:index, :new, :create]

  def index
    @users = User.all
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(params[:user])
    respond_to do |format|
      format.html do
        if @user.save
          flash[:notice] = "New user was successfully created!"
          redirect_to settings_path
        else
          render :action => :new
        end
      end
      format.js { render :action => 'validate' }
    end
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update_attributes(params[:user])
      flash[:notice] = "User account updated successfully!"
      redirect_to settings_path
    else
      render :action => :edit
    end
  end

end
