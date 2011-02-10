require 'spec_helper'

describe SecureRoutes do

  include RSpec::Rails::RequestExampleGroup

  describe 'require ssl route' do

    it 'should redirect http request' do
      get 'http://localhost/ssl_action'
      response.should be_redirect
    end

    it 'should handle https request' do
      get 'https://localhost/ssl_action'
      response.should be_success
      response.body.should == <<-BODY
/ssl_action
/action
http://localhost/no_ssl_action
https://localhost/ssl_action
https://localhost/action
http://localhost/no_ssl_action

      BODY
    end

  end

  describe 'allow ssl route' do

    it 'should handle https request' do
      get 'https://localhost/action'
      response.should be_success
      response.body.should == <<-BODY
/ssl_action
/action
http://localhost/no_ssl_action
https://localhost/ssl_action
https://localhost/action
http://localhost/no_ssl_action

      BODY
    end

    it 'should handle http request' do
      get 'http://localhost/action'
      response.should be_success
      response.body.should == <<-BODY
https://localhost/ssl_action
/action
/no_ssl_action
https://localhost/ssl_action
http://localhost/action
http://localhost/no_ssl_action

      BODY
    end

  end

  describe 'require no ssl route' do

    it 'should handle http request' do
      get 'http://localhost/no_ssl_action'
      response.should be_success
      response.body.should == <<-BODY
https://localhost/ssl_action
/action
/no_ssl_action
https://localhost/ssl_action
http://localhost/action
http://localhost/no_ssl_action

      BODY
    end

    it 'should redirect https request' do
      get 'https://localhost/no_ssl_action'
      response.should be_redirect
    end

  end

end
