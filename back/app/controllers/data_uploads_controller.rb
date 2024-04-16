class Api::DataUploadsController < ApplicationController
    def upload
        file = params[:file]
        if file.nil? || !file.content_type.in?(["application/json"])
            render json: { error: "Invalid file format. Please upload a JSON file." }, status: :bad_request
        else
            File.open(Rails.root.join('sample_data', 'qa_data.json'), 'wb') do |f|
                f.write(file.read)
            end
            render json: { success: true }
        end
    end

    def process
        ImportQaDataJob.perform_later
        IndexQaDataJob.perform_later
        render json: { success: true, message: 'Indexing process has started. Please wait a few minutes.' }
    end
end