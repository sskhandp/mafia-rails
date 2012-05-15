require "spec_helper"

describe SessionsController do
  describe "#login" do
    def make_request
      xhr :get, :login, {:fb_user_id => "999999", :fb_access_token => "ACCESS_TOKEN"}
    end

    it "should authenticate user on facebook" do
      SessionsController.should_receive(:authenticate_user_on_facebook).and_return(true)
      make_request
    end

    it "should only find_or_create_user if authentication successful" do
      SessionsController.should_receive(:authenticate_user_on_facebook).and_return(false)
      User.should_not_receive(:find_or_create_by_fb_user_id)
      make_request
    end

    it "should set the session cookie" do
      SessionsController.should_receive(:authenticate_user_on_facebook).and_return(true)
      make_request
      session[:user_id].should == User.last.id
    end
  end

  describe "#authenticate_user_on_facebook" do
    it "should compare given fb_user_id with id retrieved from facebook" do
      api = mock(Koala::Facebook::API)
      api.should_receive(:get_object).with("me").and_return({"id" => "999999"})
      Koala::Facebook::API.should_receive(:new).with("ACCESS_TOKEN").and_return(api)

      SessionsController.authenticate_user_on_facebook("999999", "ACCESS_TOKEN").should be_true
    end
  end
end
