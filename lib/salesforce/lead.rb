require 'httparty'

module Salesforce
  class Lead
    include HTTParty

    headers 'Content-Type' => 'application/json'
    debug_output $stderr if defined?(Rails) && Rails.env.development?

    attr_accessor :last_name, :email, :company, :job_title, :phone, :website,
      :credentials, :response, :errors

    CREATE_PATH = 'services/data/v29.0/sobjects/Lead/'.freeze

    # Instantiate the Lead
    # Params:
    # +attributes:: hash of strings containing the lead last_name, email, company, job_title, phone, and website
    # +credentials:: hash containing credentials to access salesforce api
    #   +instance_url:: instance url from salesforce api
    #   +token:: access token from salesforce oauth
    #
    # Example:
    #  Salesforce::Lead.new({
    #      last_name: 'Doe',
    #      email: 'john@doe.com',
    #      company: 'Foo Bar Inc.',
    #      job_title: 'Developer',
    #      phone: '55011998012345',
    #      website: 'http://johndoe.com'
    #    }, {
    #      token: 'Token123ABC',
    #      instance_url: 'http://n123.salesforce.com'
    #  })
    def initialize(attributes, credentials)
      @last_name = attributes[:last_name]
      @email = attributes[:email]
      @company = attributes[:company]
      @job_title = attributes[:job_title]
      @phone = attributes[:phone]
      @website = attributes[:website]
      @credentials = credentials
    end

    # Sends the lead to Salesforce
    #
    # Sets the reponse instance variable and returns true if the request succeeds
    #
    # or set the erros instance variable and returns false if it fails
    def create
      @response = self.class.post(create_url, headers: auth_header, body: to_json)
      success? ? true : parse_errors
    end

    # Returns true if request was succeed
    # or false if it fails
    # based on response code
    def success?
      @response.code >= 200 && @response.code < 400
    end

    # add erros from response to @errors attribute
    # returns false to indicate that the request failed
    def parse_errors
      @errors = @response.parsed_response.map do |error|
        { message: error['message'], code: error['errorCode'] }
      end

      return false
    end

    # Salesforce uses a different url prefix for each account
    # appends the CREATE_PATH with instance_url from the current account
    def create_url
      "#{ @credentials[:instance_url] }/#{ CREATE_PATH }"
    end

    # Required Authorization header to access the Salesforce API
    # uses the token from current account
    def auth_header
      { 'Authorization' => "Bearer #{ @credentials[:token] }" }
    end

    # Prepare the json to send to Salesforce API
    # The attributes accepted there are different from ours
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