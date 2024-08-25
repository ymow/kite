require 'net/http'
require 'uri'
require 'json'

class Llama2Service
  TOGETHER_API_URL = "https://api.together.xyz/v1/chat/completions"
  MODEL_NAME = "meta-llama/Llama-2-7b-chat-hf"
  MAX_TOKENS = 512

  def initialize(user_message)
    @user_message = user_message
    @api_key = Rails.application.credentials.together.api_key
  end

  def call
    relevant_places = fetch_relevant_places(@user_message)
    formatted_message = format_user_message(@user_message, relevant_places)
    binding.pry
    response = send_request_to_together_ai(formatted_message)
    parse_response(response)
  end

  private

  def fetch_relevant_places(user_message)
    search_query = user_message.downcase.strip # Normalize the user message
    results = Place.basic_search(name: search_query).order(rating: :desc).limit(10)

    if results.empty?
      # Fallback or alternative logic if no results are found
      Place.order(rating: :desc).limit(10)
    else
      results
    end
  end



  def format_user_message(user_message, places)
    # Build a user-friendly message incorporating the places
    places_info = places.map do |place|
      <<~PLACE_INFO
      Place: #{place.name}
      Address: #{place.address}, #{place.city}, #{place.state}, #{place.country}
      Category: #{place.category}
      Rating: #{place.rating} stars
      Description: #{place.description}
      Phone: #{place.phone_number}
      Website: #{place.website}
    PLACE_INFO
    end.join("\n\n")

    "#{user_message}\n\nThe following information about relevant places has been retrieved:\n#{places_info}\n\nBased on the above details, where is the place located?"
  end



  def send_request_to_together_ai(formatted_message)
    uri = URI.parse(TOGETHER_API_URL)
    http = Net::HTTP.new(uri.host, uri.port)
    http.use_ssl = true

    request = Net::HTTP::Post.new(uri.request_uri)
    request["Authorization"] = "Bearer #{@api_key}"
    request["Content-Type"] = "application/json"

    request.body = build_request_body(formatted_message).to_json

    response = http.request(request)
    response.body
  end

  def build_request_body(formatted_message)
    {
      model: MODEL_NAME,
      messages: [
        {
          role: "user",
          content: formatted_message
        }
      ],
      max_tokens: MAX_TOKENS,
      temperature: 0.7,
      top_p: 0.7,
      top_k: 50,
      repetition_penalty: 1,
      stop: ["[/INST]", "</s>"],
      stream: false
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
