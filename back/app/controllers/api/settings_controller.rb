class Api::SettingsController < ApplicationController
    skip_before_action :verify_authenticity_token
    
    def show
        render json: Setting.all
    end

    def update
        Rails.logger.debug "Request update settings: #{params['_json']}"
        settings = params['_json']
        sucess = true

        settings.each do |setting|
            s = Setting.find_or_create_by(key: setting['key'])
            if s.persisted?
                s.label = setting['label']
                s.value = setting['value']
                unless s.save
                    Rails.logger.debug "Failed to save setting: #{s.errors.full_messages.join(", ")}"
                    sucess = false
                end
            else
                Rails.logger.debug "Failed to create setting: #{s.errors.full_messages.join(", ")}"
                sucess = false
            end
        end

        render json: { success: sucess }
    end
end