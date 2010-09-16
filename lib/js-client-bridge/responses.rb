module JsClientBridge #:nodoc:
  module Responses      
    class << self
      include Responses::Ok
      include Responses::Error
      include Responses::Exception
      include Responses::Validation

      protected
      
      def formatting_parameters
        [:jsonp]
      end
      
      def respond_with(type, args)
        unless args.blank?
          options = args.last.is_a?(Hash) ? args.pop.dup : {}
          options[:_message] = args.shift.dup if args.first.is_a?(String)
        else
          options = {}
        end
        
        # separate out formatting parameters
        formatting = {}
        for para in formatting_parameters
          formatting[para] = options.delete(para) if options.include?(para)
        end
        
        [options.merge({ :_status => type.to_s }), formatting]
      end
      
      def format_response(response, formatting_options = {})
        # Handle JSONP responses
        if formatting_options[:jsonp].blank?
          response.to_json
        else
          "#{formatting_options[:jsonp]}(#{response.to_json})"
        end
      end
    end
  end # module Responses
end # module JsClientBridge