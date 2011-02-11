require File.expand_path(File.join(File.dirname(__FILE__), 'spec_helper'))

describe "Error Responses" do
  describe "#render_error" do
    it "should generate a basic error response" do
      JSON.parse(JsClientBridge::Responses.render_error).should == {'_status' => 'error'}
    end

    it "should generate a error response with a status message" do
      JSON.parse(JsClientBridge::Responses.render_error('a message')).should == {'_status' => 'error', '_message' => "a message"}
    end

    it "should generate a error response with a status message and additional custom properties" do
      JSON.parse(JsClientBridge::Responses.render_error('a message', 'blame' => 'the user')).should == {'_status' => 'error', '_message' => "a message", 'blame' => 'the user'}
    end

    it "should generate a error response with custom properties but not message" do
      JSON.parse(JsClientBridge::Responses.render_error('blame' => 'the user')).should == {'_status' => 'error', 'blame' => 'the user'}
    end

    it "should generate a basic error response using JSONP" do
      jsonp = JsClientBridge::Responses.render_error('a message', :jsonp => 'jsonp1')
      jsonp[0..6].should == 'jsonp1('
      jsonp[-1..-1].should == ')'
      JSON.parse(jsonp[7..-2]).should == {'_message' => "a message", '_status' => 'error'}
    end
  end

  describe "#respond_with_error" do
    it "should generate a basic error response" do
      JsClientBridge::Responses.respond_with_error.should == {'_status' => 'error'}
    end

    it "should generate a error response with a status message" do
      JsClientBridge::Responses.respond_with_error('a message').should == {'_status' => 'error', '_message' => "a message"}
    end

    it "should generate a error response with a status message and additional custom properties" do
      JsClientBridge::Responses.respond_with_error('a message', 'blame' => 'the user').should == {'_status' => 'error', '_message' => "a message", 'blame' => 'the user'}
    end

    it "should generate a error response with custom properties but not message" do
      JsClientBridge::Responses.respond_with_error('blame' => 'the user').should == {'_status' => 'error', 'blame' => 'the user'}
    end
  end
end
