require 'cgi'

module JSClientBridge #:nodoc:
  module Responses #:nodoc:
    module Validation
      # Generates a 'ok' status response. If the first parameter is a string is will be
      # used as the _status options. It will also honour custom optionss as long
      # they don't clash with the standard ones.
      #
      # ==== Parameters
      # message<String>:: An optional message.
      # options<Hash>:: Custom optionss.
      #
      # ==== Returns
      # JSON String::
      def respond_with_validation_error(*args)
        if args.blank? || !args.first.respond_to?(:errors_to_hash)
          raise ArgumentError.new("respond_with_validation_error requires an object that responds to errors_to_hash as it's first parameter")
        end
        
        obj = args.shift
        options = args.last.is_a?(Hash) ? args.pop : {}

        # Generate our response hash and add the exceptions parameter
        response =  if options.include?(:message)
                      options.merge(obj.errors_to_hash(options.delete(:message)))
                      
                    else
                      options.merge(obj.errors_to_hash)
                    end

        format_response(response, options)
      end

    end # module Validation
  end # module Responses
end # module JSClientBridge

=begin
{
  :_status       => 'validation',
  :_type        => self.class,
  :_short_type  => self.class.to_s.split('::').first,
  :_message      => message,
  :validation   => self.errors.to_json
}
=end