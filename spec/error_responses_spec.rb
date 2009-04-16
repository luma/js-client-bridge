require File.dirname(__FILE__) + '/spec_helper'

describe "Error Responses" do
  it "should generate a basic error response" do
    JSClientBridge::Responses.respond_with_error.should == {:_status => 'error'}.to_json
  end

  it "should generate a error response with a status message" do
    JSClientBridge::Responses.respond_with_error('a message').should == {:_status => 'error', :_message => "a message"}.to_json
  end

  it "should generate a error response with a status message and additional custom properties" do
    JSClientBridge::Responses.respond_with_error('a message', :blame => 'the user').should == {:_status => 'error', :_message => "a message", :blame => 'the user'}.to_json
  end
  
  it "should generate a error response with custom properties but not message" do
    JSClientBridge::Responses.respond_with_error(:blame => 'the user').should == {:_status => 'error', :blame => 'the user'}.to_json
  end
  
  it "should generate a basic error response using JSONP" do
    JSClientBridge::Responses.respond_with_error('a message', :jsonp => 'jsonp1').should == "jsonp1(#{{:_status => 'error', :_message => "a message"}.to_json})"
  end
end
