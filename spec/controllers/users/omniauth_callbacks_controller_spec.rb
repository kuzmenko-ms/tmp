require 'spec_helper'

describe Users::OmniauthCallbacksController do

  describe "GET 'vkontakte'" do
    it "returns http success" do
      get 'vkontakte'
      response.should be_success
    end
  end

end
