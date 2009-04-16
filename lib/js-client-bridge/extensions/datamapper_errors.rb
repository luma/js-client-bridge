
module DataMapper
  module Validate

    ##
    #
    # Monkey patch of Datamapper to add a nice to_json method that uses our error format
    class ValidationErrors

      def to_hash
        js = {}
      
        errors.each do |list, pair|
          js[list] = pair
        end
      
        js
      end

    end # class ValidationErrors
  end # module Validate
end # module DataMapper

module DataMapper
  module Resource
    def errors_to_hash(message = "Sorry, we couldn't save your #{self.class.to_s.split('::').last}")
    
      short_type = self.class.to_s.split('::').last
    
      validation = {
        :_status       => 'validation',
        :_type        => self.class,
        :_short_type  => short_type,
        :_message      => message,
        :validation   => self.errors.to_hash,
      }
    
      validation[:id] = self.id.to_s unless new_record?
    
      validation
    end
  end # module Resource
end # module DataMapper