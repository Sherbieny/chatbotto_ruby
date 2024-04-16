class Api::ChatbotController < ApplicationController
    def get_suggestions
        query = params[:query]
        suggestions = Qa.search(query)
        render json: suggestions
    end

    def send_message
        query = params[:query]
        prompts = Qa.search(query)

        if prompts.empty?
          render json: { message: 'その質問に対する答えはわかりません。' }
        else
          answer = Qa.get_answer(prompts.first['prompt'])

          if answer.nil?
            render json: { message: 'その質問に対する答えはわかりません。' }
          else
            render json: { message: answer }
          end
        end
    end
end