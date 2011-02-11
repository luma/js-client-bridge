require 'cgi'

module JsClientBridge #:nodoc:
  module Responses #:nodoc:
    module Error
      # Generates a error response. If the first parameter is a string is will be
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
      def respond_with_error(*args)
        respond_with('error', args).first
      end

      # Generates a error response. If the first parameter is a string is will be
      # used as the _status options. It will also honour custom optionss as long
      # they don't clash with the standard ones.
      #
      # @param <String> message
      #   An optional message.
      # @param <Hash> options
      #   Custom optionss.
      #
      # @return <Hash>
      #   The response as a String encoded JSON object.
      def render_error(*args)
        format_response(*respond_with('error', args))
      end
    end # module Error
  end # module Responses
end # module JsClientBridge