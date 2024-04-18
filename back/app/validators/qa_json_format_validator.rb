class QaJsonFormatValidator < ActiveModel::EachValidator
    def validate_each(record, attribute, value)
        begin
            data = JSON.parse(value.read)

            unless data.all? { |item| item['prompt'] && item['answer'] }
                record.errors.add(attribute, "must be a valid JSON.")
            end
        rescue JSON::ParserError
            record.errors.add(attribute, "must be a valid JSON.")
        end
    end
end