require File.expand_path(File.join(File.dirname(__FILE__), 'spec_helper'))

require 'dm-core'
require 'dm-aggregates'
require 'dm-migrations'
require 'dm-timestamps'
require 'dm-types'
require 'dm-validations'

module Luma
  module Test
    class TestDO
      include DataMapper::Resource

      property :id,                     String, :key => true, :length => 36

      property :subject,                String, :length => 30..155, :required => true
      property :body,                   Text, :required => true
    end # class Message
  end
end
  
describe "Validation Responses" do
  before(:all) do
    DataMapper.setup(:default, 'sqlite3::memory:')
    DataMapper.auto_migrate!
  end
  
  describe "#respond_with_validation" do
    it "should generate a basic validation response" do
      test_do = Luma::Test::TestDO.new(:id => 'bob')
      test_do.save.should be_false

      ex = JsClientBridge::Responses.respond_with_validation_error(test_do)
      pp ex
      ex['validation'].length.should == 2
      ex['_short_type'].should == "TestDO"
      ex['_type'].should == "Luma::Test::TestDO"
    end
  end

  describe "#render_validation" do
    it "should generate a basic validation response" do
      test_do = Luma::Test::TestDO.new(:id => 'bob')
      test_do.save.should be_false

      ex = JSON.parse(JsClientBridge::Responses.render_validation(test_do))
      pp ex
      ex['validation'].length.should == 2
      ex['_short_type'].should == "TestDO"
      ex['_type'].should == "Luma::Test::TestDO"
    end

    it "should generate a basic validation response using JSONP" do
      test_do = Luma::Test::TestDO.new(:id => 'bob')
      test_do.save.should be_false

      ex = JsClientBridge::Responses.render_validation(test_do, :jsonp => 'jsonp1')
      ex[0..6].should == 'jsonp1('
      ex[-1..-1].should == ')'
    end
  end
end


=begin
{
  :_status       => 'validation',
  :_type        => self.class,
  :_short_type  => self.class.to_s.split('::').first,
  :_message      => message,
  :validation   => self.errors.to_json
}

{
  "validation"=> {
                    "body"    =>  ["Body must not be blank"],
                    "subject" =>  ["Subject must not be blank", "Subject must be between 30 and 155 characters long"],
                    "id"      =>  ["Id must not be blank"]
                  },
 "_short_type"  => "TestDO",
 "_status"      => "validation",
 "_type"        => "Luma::Test::TestDO",
 "_message"     => "Sorry, we couldn't save your TestDO"
}

=end