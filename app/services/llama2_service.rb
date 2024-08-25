require 'net/http'
require 'uri'
require 'json'

class Llama2Service
  TOGETHER_API_URL = "https://api.together.xyz/v1/chat/completions"
  MODEL_NAME = "meta-llama/Llama-2-7b-chat-hf"

  def initialize(user_message)
    @user_message = user_message
    @api_key = Rails.application.credentials.together.api_key
  end

  def call
    response = send_request_to_together_ai
    parse_response(response)
  end

  private

  def send_request_to_together_ai
    uri = URI.parse(TOGETHER_API_URL)
    http = Net::HTTP.new(uri.host, uri.port)
    http.use_ssl = true

    request = Net::HTTP::Post.new(uri.request_uri)
    request["Authorization"] = "Bearer #{@api_key}"
    request["Content-Type"] = "application/json"

    request.body = build_request_body.to_json

    response = http.request(request)
    response.body
  end

  def build_request_body
    {
      model: MODEL_NAME,
      messages: [
        {
          role: "user",
          content: @user_message
        }
      ],
      max_tokens: 512,
      temperature: 0.7,
      top_p: 0.7,
      top_k: 50,
      repetition_penalty: 1,
      stop: ["[/INST]","</s>"],
      stream: false # Set to true if you handle streaming responses differently
    }
  end

  def parse_response(response_body)
    parsed_response = JSON.parse(response_body)
    if parsed_response["choices"] && parsed_response["choices"].first["message"]
      parsed_response["choices"].first["message"]["content"]
    else
      "Sorry, I couldn't process your request at this time."
    end
  end
end
