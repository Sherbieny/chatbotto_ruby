class ImportQaDataJob < ApplicationJob
    queue_as :default

    def perform(*args)
        dir_path = Rails.root.join('sample_data')

        unless Dir.exist?(dir_path)
            Rails.logger.error "Directory not found: #{dir_path}"
            return
        end

        files = Dir.glob("#{dir_path}/*.json")

        ActiveRecord::Base.transaction do
            begin
                ActiveRecord::Base.connection.execute('CREATE TEMPORARY TABLE temp_qa AS SELECT * FROM qas WITH NO DATA')

                files.each do |file|
                    Rails.logger.info "Processing file: #{file}"
                    data = JSON.parse(File.read(file))

                    data.each do |item|
                        unless item['prompt'] && item['answer']
                            Rails.logger.error "Invalid data in file #{file}: missing 'prompt' or 'answer'"
                            raise ActiveRecord::Rollback
                        end

                        Rails.logger.info "Importing data: #{item}"
                        ActiveRecord::Base.connection.execute("INSERT INTO temp_qa (prompt, answer) VALUES (#{ActiveRecord::Base.connection.quote(item['prompt'])}, #{ActiveRecord::Base.connection.quote(item['answer'])})")
                    end
                end

                ActiveRecord::Base.connection.execute('INSERT INTO qas (prompt, answer, created_at, updated_at)
                                                                                                SELECT prompt, answer, NOW(), NOW() FROM temp_qa
                                                                                                WHERE (prompt, answer) NOT IN (SELECT prompt, answer FROM qas)')

                ActiveRecord::Base.connection.execute('DROP TABLE IF EXISTS temp_qa')
                Rails.logger.info 'Data imported successfully'
            rescue => e
                Rails.logger.error "An error occurred while importing data: #{e.message}"
                raise ActiveRecord::Rollback
            end
        end
    end
end