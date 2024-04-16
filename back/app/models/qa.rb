class Qa < ApplicationRecord
    def self.search(query)
        columns = ['prompt']
        suggestions_count = Setting.find_by(key: 'suggestions_count')&.value.to_i || 5

        search_query = self
        columns.each do |column|
            search_query = search_query.or(self.where("#{column} ILIKE ?", "%#{query}%"))
        end

        search_query.limit(suggestions_count).map do |item|
            { 'prompt' => item.prompt, 'answer' => item.answer }
        end
    end

    def self.get_answer(prompt)
        self.find_by(prompt: prompt)&.answer
    end
end