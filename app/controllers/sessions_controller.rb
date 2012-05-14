class SessionsController < ApplicationController
  def login
    respond_to do |type|
      type.json {
        if SessionsController.authenticate_user_on_facebook(params["fb_user_id"], params["fb_access_token"])
          user = User.find_or_create_by_fb_user_id(params["fb_user_id"])
          if user.invalid?
            render :json => {:errors => {:type => "User", :messages => user.errors.full_messages}}, :status => :unprocessable_entity
          else
            user.update_attributes({:name => params["name"], :fb_access_token => params["fb_access_token"]})
            session[:user_id] = user.id
            render :json => {}, :status => :success
          end
        else
          render :json => {:errors => {:type => "FacebookAuthentication", :messages => ["Could not authenticate user on facebook."]}}, :status => :unprocessable_entity
        end
      }
    end
  end

  def self.authenticate_user_on_facebook(fb_user_id, fb_access_token)
    graph = Koala::Facebook::API.new(fb_access_token)
    profile = JSON.parse(graph.get_object("me"))
    fb_user_id == profile["id"]
  end
end
