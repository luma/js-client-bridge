require 'cgi'

module JsClientBridge #:nodoc:
  module Responses #:nodoc:
    module Ok
      # Generates a 'ok' status response as a Hash. If the first parameter is a string is will be
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
      def respond_with_ok(*args)
        respond_with('ok', args).first
      end

      # Generates a 'ok' status response. If the first parameter is a string is will be
      # used as the _status options. It will also honour custom optionss as long
      # they don't clash with the standard ones.
      #
      # @param <String> message
      #   An optional message.
      # @param <Hash> options
      #   Custom optionss.
      #
      # @return <String>
      #   A JSON object encoded as a String.
      def render_ok(*args)
        format_response(*respond_with('ok', args))
      end
    end # module Ok
  end # module Responses
end # module JsClientBridge
