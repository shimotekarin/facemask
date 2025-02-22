class UsersController < ApplicationController
    def show
        @user = User.find(params[:id]) 
        @drafts = @user.masks.where(is_draft: true).order(created_at: :desc)
    end
end