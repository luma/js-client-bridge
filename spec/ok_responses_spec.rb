require File.expand_path(File.join(File.dirname(__FILE__), 'spec_helper'))




describe "Ok Responses" do
  describe "#respond_with_ok" do
    it "should generate a basic ok response" do
      JsClientBridge::Responses.respond_with_ok.should == {'_status' => 'ok'}
    end

    it "should generate a ok response with a status message" do
      JsClientBridge::Responses.respond_with_ok('a message').should == {'_status' => 'ok', '_message' => "a message"}
    end

    it "should generate a ok response with a status message and additional custom parameters" do
      JsClientBridge::Responses.respond_with_ok('a message', 'awesomeness' => 'has happened').should == {'_status' => 'ok', '_message' => "a message", 'awesomeness' => 'has happened'}
    end

    it "should generate a ok response with a status message and a complex parameters" do
      JsClientBridge::Responses.respond_with_ok('a message', 'stuff' => complext_test_data).should == {'_message' => "a message", 'stuff' => complext_test_data, '_status' => 'ok'}
    end
  end

  describe "#render_ok" do
    it "should generate a basic ok response" do
      JSON.parse(JsClientBridge::Responses.render_ok).should == {'_status' => 'ok'}
    end

    it "should generate a ok response with a status message" do
      JSON.parse(JsClientBridge::Responses.render_ok('a message')).should == {'_status' => 'ok', '_message' => "a message"}
    end

    it "should generate a ok response with a status message and additional custom parameters" do
      JSON.parse(JsClientBridge::Responses.render_ok('a message', 'awesomeness' => 'has happened')).should == {'_status' => 'ok', '_message' => "a message", 'awesomeness' => 'has happened'}
    end

    it "should generate a ok response with a status message and a complex parameters" do
      JSON.parse(JsClientBridge::Responses.render_ok('a message', 'stuff' => complext_test_data)).should == {'_message' => "a message", 'stuff' => complext_test_data, '_status' => 'ok'}
    end

    it "should generate a basic ok response using JSONP" do
      jsonp = JsClientBridge::Responses.render_ok('a message', :jsonp => 'jsonp1')
      jsonp[0..6].should == 'jsonp1('
      jsonp[-1..-1].should == ')'
      JSON.parse(jsonp[7..-2]).should == {'_status' => 'ok', '_message' => "a message"}
    end
  end

  def complext_test_data
    [
      {'name'=>"Whangarei",
      'description'=>"Northland Coach & Travel Centre, 3C Bank St.",
      'id'=>'WRE'},
      {'name'=>"Westwood Lodge", 'description'=>"Westwood Lodge", 'id'=>'WWL'},
      {'name'=>"Queenstown YHA Lake Esplanade",
      'description'=>"Queenstown YHA, 80 Lake Esplanade",
      'id'=>'YHQ'},
      {'name'=>"Queenstown Airport", 'description'=>"Queenstown Airport", 'id'=>'ZQA'},
      {'name'=>"Queenstown",
      'description'=>"Athol Street in the middle of the car park",
      'id'=>'ZQN'},
      {'name'=>"Queenstown The Station",
      'description'=>"The Station, corner of Camp and Shotover Streets",
      'id'=>'ZQT'}
    ]
  end

end

