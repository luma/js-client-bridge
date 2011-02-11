require 'cgi'

module JsClientBridge #:nodoc:
  module Responses #:nodoc:
    module Validation
      # Generates a validation error status response. If the first parameter is a string is will be
      # used as the _status options. It will also honour custom optionss as long
      # they don't clash with the standard ones.
      #
      # @param <String> message
      #   An optional message.
      # @param <Hash> options
      #   Custom optionss.
      #
      # @return <Hash>
      #   The response as a Hash
      def respond_with_validation_error(*args)
        obj = args.shift
        options = args.last.is_a?(Hash) ? args.pop : {}

        # Generate our response hash and add the exceptions parameter
        response =  if options.include?(:message)
                      options.merge( validation_errors_to_hash(obj, options.delete(:message)) )
                    else
                      options.merge( validation_errors_to_hash(obj) )
                    end

        response
      end

      # Generates a validation error status response. If the first parameter is a string is will be
      # used as the _status options. It will also honour custom optionss as long
      # they don't clash with the standard ones.
      #
      # @param <String> message
      #   An optional message.
      # @param <Hash> options
      #   Custom optionss.
      #
      # @return <String>
      #   The response as a String encoded JSON object
      def render_validation(*args)
        obj = args.shift
        options = args.last.is_a?(Hash) ? args.pop : {}

        # Generate our response hash and add the exceptions parameter
        response =  if options.include?(:message)
                      options.merge( validation_errors_to_hash(obj, options.delete(:message)) )
                    else
                      options.merge( validation_errors_to_hash(obj) )
                    end

        format_response(response, options)
      end

      protected
      
      def validation_errors_to_hash(data_object, message = "Sorry, we couldn't save your #{data_object.class.to_s.split('::').last}")
        short_type = data_object.class.to_s.split('::').last
    
        validation = {
          '_status'       => 'validation',
          '_type'        => data_object.class.to_s,
          '_short_type'  => short_type,
          '_message'      => message,
          'validation'   => data_object.errors.to_hash,
        }
    
        validation['id'] = data_object.id.to_s unless data_object.new?
    
        validation
      end


    end # module Validation
  end # module Responses
end # module JsClientBridge