require 'httparty'

module Salesforce
  class Lead
    include HTTParty

    headers 'Content-Type' => 'application/json'
    debug_output $stderr if Rails.env.development?

    attr_accessor :name, :last_name, :email, :company, :job_title, :phone, :website, :errors

    CREATE_PATH = 'services/data/v29.0/sobjects/Lead/'.freeze

    def initialize(attributes)
      p attributes
      @name = attributes['name']
      @last_name = attributes['last_name']
      @email = attributes['email']
      @company = attributes['company']
      @job_title = attributes['job_title']
      @phone = attributes['phone']
      @website = attributes['website']
    end

    def create(credentials)
      response = self.class.post("#{ credentials['instance_url'] }/#{ CREATE_PATH }",
        headers: { 'Authorization' => "Bearer #{ credentials['token'] }" },
        body: self.to_json)

      unless response.code >= 200 && response.code < 400
        @errors = response.parsed_response.map do |error|
          { message: error['message'], code: error['errorCode'] }
        end
        return false
      else
        return true
      end
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