Rails.application.routes.draw do
    # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

    # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
    # Can be used by load balancers and uptime monitors to verify that the app is live.
    get "up" => "rails/health#show", as: :rails_health_check

    # Defines the root path route ("/")
    # root "posts#index"

    namespace :api do
        get 'suggestions', to: 'chatbot#get_suggestions'
        post 'message', to: 'chatbot#process_message'
        get 'settings', to: 'settings#show'
        post 'settings', to: 'settings#update'
        post 'upload', to: 'data_uploads#upload'
        post 'process', to: 'data_uploads#process'
    end
end