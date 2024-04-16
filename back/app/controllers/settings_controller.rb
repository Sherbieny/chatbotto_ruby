class Api::SettingsController < ApplicationController
    def get_settings
        render json: Setting.all
    end

    def save_settings
        params[:settings].each do |setting|
            Setting.find_or_create_by(key: setting[:key]) do |s|
                s.label = setting[:label]
                s.value = setting[:value]
                s.save
            end
        end
        head :ok
    end
end