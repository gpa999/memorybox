class UsersController < ApplicationController
    before_action :authenticate_user!, except: :show
    before_action :redirect_root, only: [:edit, :update]

    def show
        @user = User.find(params[:id])
    end

    def edit 
        @user = User.find(params[:id])
    end

    def update
        user = User.find(params[:id])
        if user == current_user 
            user.update(user_params)
        end
        redirect_to user_path
    end

    private

    def redirect_root
        user = User.find(params[:id])
        if user != current_user 
            redirect_to root_path
        end
    end

    def user_params
        params.require(:user).permit(:image, :text)
    end

end
