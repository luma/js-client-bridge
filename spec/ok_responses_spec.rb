require File.dirname(__FILE__) + '/spec_helper'




describe "Ok Responses" do
  it "should generate a basic ok response" do
    JSClientBridge::Responses.respond_with_ok.should == {:_status => 'ok'}.to_json
  end

  it "should generate a ok response with a status message" do
    JSClientBridge::Responses.respond_with_ok('a message').should == {:_status => 'ok', :_message => "a message"}.to_json
  end

  it "should generate a ok response with a status message and additional custom parameters" do
    JSClientBridge::Responses.respond_with_ok('a message', :awesomeness => 'has happened').should == {:_status => 'ok', :_message => "a message", :awesomeness => 'has happened'}.to_json
  end
  
  it "should generate a ok response with a status message and a complex parameters" do
    JSClientBridge::Responses.respond_with_ok('a message', :stuff => complext_test_data).should == {:_message => "a message", :stuff => complext_test_data, :_status => 'ok'}.to_json
  end
  
  it "should generate a basic ok response using JSONP" do
    JSClientBridge::Responses.respond_with_ok('a message', :jsonp => 'jsonp1').should == "jsonp1(#{{:_status => 'ok', :_message => "a message"}.to_json})"
  end
  
  def complext_test_data
    [
      {:name=>"Whangarei",
      :description=>"Northland Coach & Travel Centre, 3C Bank St.",
      :id=>:WRE},
      {:name=>"Westwood Lodge", :description=>"Westwood Lodge", :id=>:WWL},
      {:name=>"Queenstown YHA Lake Esplanade",
      :description=>"Queenstown YHA, 80 Lake Esplanade",
      :id=>:YHQ},
      {:name=>"Queenstown Airport", :description=>"Queenstown Airport", :id=>:ZQA},
      {:name=>"Queenstown",
      :description=>"Athol Street in the middle of the car park",
      :id=>:ZQN},
      {:name=>"Queenstown The Station",
      :description=>"The Station, corner of Camp and Shotover Streets",
      :id=>:ZQT}
    ]
  end
end

