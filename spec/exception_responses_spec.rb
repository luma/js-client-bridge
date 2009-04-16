require File.dirname(__FILE__) + '/spec_helper'



class TestException < StandardError; end

describe "Exception Responses" do

  it "should generate an exception response" do
    exception = TestException.new('An exception')

    ex = JSON.parse(JSClientBridge::Responses.respond_with_exception(exception, :request_uri => '/', :parameters => {:param1 => 'value1'}))

    ex['_status'].should == 'exception'
    ex['request_uri'].should == '/'
    ex['parameters'].should == {'param1' => 'value1'}
    ex['exceptions'].length.should == 1

    e = ex['exceptions'].first
    e['name'].should == exception.class.to_s
    e['message'].should == CGI.escape(exception.message)
    e['backtrace'].should == exception.backtrace
    e['short_name'].should == exception.class.to_s.split('::').last
  end

  it "should generate an exceptions response" do
    exceptions = [TestException.new('An exception'), TestException.new('Another exception')]

    ex = JSON.parse(JSClientBridge::Responses.respond_with_exceptions(exceptions, :request_uri => '/', :parameters => {:param1 => 'value1'}))

    ex['_status'].should == 'exception'
    ex['request_uri'].should == '/'
    ex['parameters'].should == {'param1' => 'value1'}
    ex['exceptions'].length.should == 2
  end

  it "should require the request_uri option" do
    lambda {
      JSClientBridge::Responses.respond_with_exception(TestException.new('An exception'), :parameters => {:param1 => 'value1'})
    }.should raise_error(ArgumentError)
  end

  it "should require the exception option" do
    lambda {
      JSClientBridge::Responses.respond_with_exception(:request_uri => '/', :parameters => {:param1 => 'value1'})
    }.should raise_error(ArgumentError)
  end
  
  it "should generate an exception response using JSONP" do
    exception = TestException.new('An exception')

    ex = JSClientBridge::Responses.respond_with_exception(exception, :request_uri => '/', :parameters => {:param1 => 'value1'}, :jsonp => 'jsonp1')
    ex[0..6].should == 'jsonp1('
    ex[-1..-1].should == ')'
  end
end