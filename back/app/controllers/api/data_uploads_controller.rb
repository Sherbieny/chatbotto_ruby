class Api::DataUploadsController < ApplicationController
    skip_before_action :verify_authenticity_token

    def upload
        file = params[:file]
        if file.nil? || !file.content_type.in?(["application/json"])
            render json: { error: "Invalid file format. Please upload a JSON file." }, status: :bad_request
        else
            data_upload = OpenStruct.new(file: file)
            data_upload.extend ActiveModel::Validations
            data_upload.validate { QaJsonFormatValidator.new.validate(data_upload) }

            if data_upload.errors.empty?
                File.open(Rails.root.join('sample_data', 'qa_data.json'), 'wb') do |f|
                    f.write(file.read)
                end
                render json: { success: true }
            else
                render json: { error: data_upload.errors.full_messages }, status: :bad_request
            end
        end
    end

    def process_data
        ImportQaDataJob.perform_later
        IndexQaDataJob.perform_later
        render json: { success: true, message: 'Indexing process has started. Please wait a few minutes.' }
    end
end