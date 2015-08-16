require 'httparty'

module Salesforce
  class Lead
    include HTTParty

    headers 'Content-Type' => 'application/json'
    debug_output $stderr if defined?(Rails) && Rails.env.development?

    attr_accessor :last_name, :email, :company, :job_title, :phone, :website,
      :credentials, :response, :errors

    CREATE_PATH = 'services/data/v29.0/sobjects/Lead/'.freeze

    def initialize(attributes, credentials)
      @last_name = attributes[:last_name]
      @email = attributes[:email]
      @company = attributes[:company]
      @job_title = attributes[:job_title]
      @phone = attributes[:phone]
      @website = attributes[:website]
      @credentials = credentials
    end

    def create
      @response = self.class.post(create_url, headers: auth_header, body: to_json)
      success? ? true : parse_errors
    end

    def success?
      @response.code >= 200 && @response.code < 400
    end

    def parse_errors
      @errors = @response.parsed_response.map do |error|
        { message: error['message'], code: error['errorCode'] }
      end

      return false
    end

    def create_url
      "#{ @credentials[:instance_url] }/#{ CREATE_PATH }"
    end

    def auth_header
      { 'Authorization' => "Bearer #{ @credentials[:token] }" }
    end

    def to_json
      {
        'LastName' => last_name,
        'Email' => email,
        'Company' => company,
        'Title' => job_title,
        'Phone' => phone,
        'Website' => website
      }.to_json
    end
  end
end