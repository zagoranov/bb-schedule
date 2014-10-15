class FriendshipsController < ApplicationController

respond_to :html, :js

def create
  @friendship = current_user.friendships.build(:friend_id => params[:friend_id])
  if @friendship.save
    flash[:notice] = t(:fr_added)
    redirect_to users_path
  else
    flash[:error] = t(:fr_error)
    redirect_to current_user, :notice => t(:fr_added)
  end
end


def destroy
  @friendship = current_user.friendships.find(params[:id])
  @friendship.destroy
  flash[:notice] = t(:fr_removed)
  redirect_to current_user, :notice => t(:fr_removed)
 end



def wellhello
  @friendship = current_user.friendships.build(:friend_id => params[:id])
  if @friendship.save
    if params[:from] == 'list'
      @users = User.limit(30).order("RANDOM()")
      respond_to do |format|
        format.js { render partial: '/users/list_refresh'  }
      end
    else
      @user = User.find(params['who'])
      respond_to do |format|
        format.js { render partial: '/users/profile_refresh'  }
      end
    end
  end
end



def byebye
  @friendship = current_user.friendships.find(params[:id])
  @friendship.destroy
  if params[:from] == 'list'
    @users = User.limit(30).order("RANDOM()")
    respond_to do |format|
      format.js { render partial: '/users/list_refresh'  }
    end
  else
    @user = User.find(params['who'])
    respond_to do |format|
      format.js { render partial: '/users/profile_refresh'  }
    end
  end
 end



end
