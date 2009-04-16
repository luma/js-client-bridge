require 'cgi'

module JSClientBridge #:nodoc:
  module Responses #:nodoc:
    module Exception
      
      def respond_with_exception(*args)
        raise ArgumentError.new("respond_with_exception requires an exception as it's first parameter") if args.blank? || !args.first.is_a?(StandardError)
        
        exception = args.shift
        options = args.last.is_a?(Hash) ? args.pop : {}

        # Ensure we have our required fields
        raise ArgumentError.new("respond_with_exception requires the request_uri option") unless options.include?(:request_uri)

        # Set some defaults
        options[:parameters] ||= {}

        # Generate our response hash and add the exceptions parameter
        response, formatting = respond_with('exception', [options])
        response[:exceptions] = [{
          :name       => exception.class,
          :short_name => exception.class.to_s.split('::').last,
          :message    => CGI.escape(exception.message),
          :backtrace  => exception.backtrace
        }]

        format_response(response, formatting)
      end

      def respond_with_exceptions(*args)
        raise ArgumentError.new("respond_with_exception requires an array of exceptions as it's first parameter") if args.blank? || !args.first.is_a?(Array)
        
        exceptions = args.shift
        options = args.last.is_a?(Hash) ? args.pop : {}

        # Ensure we have our required fields
        raise ArgumentError.new("respond_with_exception requires the request_uri option") unless options.include?(:request_uri)

        # Set some defaults
        options[:parameters] ||= {}

        # Generate our response hash and add the exceptions parameter
        response, formatting = respond_with('exception', [options])
        
        response[:exceptions] = exceptions.map do |exception|
          {
            :name       => exception.class,
            :short_name => exception.class.to_s.split('::').last,
            :message    => CGI.escape(exception.message),
            :backtrace  => exception.backtrace
          }
        end
        
        format_response(response, formatting)
      end

    end # module Exception
  end # module Responses
end # module JSClientBridge
