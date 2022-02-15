class UsersController < ApplicationController
  def my_portfolio
    @tracked_stocks = current_user.stocks
  end

  def my_friends
    @my_friends = current_user.friends
  end

  def search
    if params[:user].present?
      @users = User.search(params[:user])
      @users = current_user.except_current_user(@users)
      
      if @users
        respond_to do |format|
          format.js { render partial: 'users/friends_result' }
        end
      else
        respond_to do |format|
          flash.now[:alert] = "Please enter a friend name or email to search"
          format.js { render partial: 'users/friends_result' }
        end
      end
    else
      respond_to do |format|
        flash.now[:alert] = "Please enter a user name or email to search"
        format.js { render partial: 'users/friends_result' }
      end
    end
  end
end

