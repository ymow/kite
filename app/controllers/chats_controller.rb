class ChatsController < ApplicationController
  protect_from_forgery with: :null_session

  def send_message
    user_message = params[:message]

    llama2_response = Llama2Service.new(user_message).call

    render json: { reply: llama2_response }
  end
end
