class UsersController < ApplicationController
  def show
    @user = User.find(params[:id])
  end

  def new
  	@user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      sign_in @user
      flash[:success] = "Holy Chickens! Welcome!"
      redirect_to @user
    else
      render 'new'
    end
  end

    private

    def user_params
      params.require(:user).permit(:name, :email, :password,
                                   :password_confirmation)
    end

    def create_remember_token
       self.remember_token = SecureRandom.urlsafe_base64
    end

    def destroy
      sign_out
      redirect_to root_url
    end
  end
