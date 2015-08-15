module Salesforce
  class Account
    attr_accessor :token, :instance_url

    def initialize(options)
      @token = options.token
      @instance_url = options.instance_url
    end
  end
end