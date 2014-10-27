require 'json-schema/attribute'

module JSON
  class Schema
    class DateFormat < FormatAttribute
      REGEXP = Regexp.new('^\d\d\d\d-\d\d-\d\d$')

      def self.validate(current_schema, data, fragments, processor, validator, options = {})
        if data.is_a?(String)
          error_message = "The property '#{build_fragment(fragments)}' must be a date in the format of YYYY-MM-DD"
          if REGEXP.match(data)
            begin
              Date.parse(data)
            rescue Exception
              validation_error(processor, error_message, fragments, current_schema, self, options[:record_errors])
            end
          else
            validation_error(processor, error_message, fragments, current_schema, self, options[:record_errors])
          end
        end
      end
    end
  end
end
