class UsersController < ApplicationController
  def new
    @title = %(Sign up)
    @user = User.new
  end
  
  def show
    @user = User.find(params[:id])
    @title = %(#{@user.first_name} #{@user.last_name})
  end

  def create
    @user = User.new(params[:user])
    if User.count < 50
      if @user.save
        flash[:success] = "Welcome to Medecin Quebec!"
        redirect_to @user
      else
        @title = %(Sign up)
        render :new
      end
    else
      flash[:message] = %(Too many users in the db)
      redirect_to root_path
    end
  end
end
