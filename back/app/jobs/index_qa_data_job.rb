class IndexQaDataJob < ApplicationJob
    queue_as :default

    def perform(*args)
        ActiveRecord::Base.transaction do
            begin
                ActiveRecord::Base.connection.execute('DROP INDEX IF EXISTS qa_prompt_index')
                ActiveRecord::Base.connection.execute('DROP INDEX IF EXISTS qa_answer_index')
                ActiveRecord::Base.connection.execute("CREATE INDEX qa_prompt_index ON qas USING pgroonga (prompt) WITH (tokenizer='TokenMecab')")
                ActiveRecord::Base.connection.execute("CREATE INDEX qa_answer_index ON qas USING pgroonga (answer) WITH (tokenizer='TokenMecab')")
            rescue => e
                Rails.logger.error "An error occurred while indexing data: #{e.message}"
                raise ActiveRecord::Rollback
            end
        end
    end
end