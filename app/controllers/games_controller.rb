class GamesController < ApplicationController
  def create
    respond_to do |type|
      type.json {
        render :json => {:errors => {:type => "InvalidSession", :messages => ["Invalid user session"]}} if @current_user.blank?

        begin
          Game.transaction do
            game = Game.new(:owner => @current_user, :state => "pending")
            game.build_membership(:user => @current_user)
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

  def show
    respond_to do |type|
      type.json {
        render :json => {:errors => {:type => "InvalidSession", :messages => ["Invalid user session"]}} if @current_user.blank?
        games = Game.find_all_by_user_id(@current_user.id)
        render :json => {games}, :status => :ok
      }
    end
  end
end
