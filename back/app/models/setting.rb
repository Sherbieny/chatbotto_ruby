class Setting < ApplicationRecord
    def self.get_suggestions_count
        count = self.find_by(key: 'suggestionsCount')&.value.to_i
        count > 0 ? count : 5
    end
end