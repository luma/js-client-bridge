require 'cgi'

module JsClientBridge #:nodoc:
  module Responses #:nodoc:
    module Ok
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
      def respond_with_ok(*args)
        format_response(*respond_with('ok', args))
      end
    end # module Ok
  end # module Responses
end # module JsClientBridge
