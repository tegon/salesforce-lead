module Salesforce
  class Lead
    attr_accessor :name, :last_name, :email, :company, :job_title, :phone, :website

    def create(account:)
      return false unless account && account.is_a?(Account)

      self.class.post(account.instance_url)
    end
  end
end