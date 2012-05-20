class GamesController < ApplicationController
  def create
    respond_to do |type|
      type.json {
        if current_user.blank?
          render :json => {:errors => {:type => "InvalidSession", :messages => ["Invalid user session"]}}
          return
        end
        begin
          Game.transaction do
            game = Game.new(:owner => current_user, :state => "pending")
            game.build_membership(:user => current_user)
            game.save
            if game.valid?
              render :json => {:game => game}, :status => :ok
            else
              render :json => {:errors => {:type => "GameCreation", :messages => ["Could not create Game.Please try again."]}}, :status => :unprocessable_entity
            end
          end
        rescue Exception => e
          render :json => {:errors => {:type => "GameCreation", :messages => [e.messages]}}, :status => :unprocessable_entity
        end
      }
    end
  end

  def index
    respond_to do |type|
      type.json {
        if current_user.blank?
          render :json => {:errors => {:type => "InvalidSession", :messages => ["Invalid user session"]}}
          return
        end
        render :json => {:games => current_user.games}, :status => :ok
      }
    end
  end
end
