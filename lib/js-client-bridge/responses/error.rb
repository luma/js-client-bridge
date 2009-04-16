require 'cgi'

module JSClientBridge #:nodoc:
  module Responses #:nodoc:
    module Error
      # Generates a error response. If the first parameter is a string is will be
      # used as the _status options. It will also honour custom optionss as long
      # they don't clash with the standard ones.
      #
      # ==== Parameters
      # message<String>:: An optional message.
      # options<Hash>:: Custom optionss.
      #
      # ==== Returns
      # JSON String:: 
      def respond_with_error(*args)
        format_response(*respond_with('error', args))
      end

    end # module Error
  end # module Responses
end # module JSClientBridge