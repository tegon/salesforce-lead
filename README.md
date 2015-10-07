# salesforce-lead
Create Leads using Salesforce API

[![Gem Version](https://badge.fury.io/rb/salesforce-lead.svg)](http://badge.fury.io/rb/salesforce-lead)

#Usage

###Constructor
---

```ruby
	attributes: {
		last_name: String
		email: String
		company: String
		job_title: String
		phone: String
		website: String
	}
	credentials: {
		token: String
		instance_url: String
	}
```

####Example

```ruby
Salesforce::Lead.new({
    last_name: 'Doe',
    email: 'john@doe.com',
    company: 'Foo Bar Inc.',
    job_title: 'Developer',
    phone: '55011998012345',
    website: 'http://johndoe.com'
  }, { 
    token: 'Token123ABC', 
    instance_url: 'http://n123.salesforce.com' 
})
```

###Methods
---

####create

Sends the Lead to Salesforce API. Returns false if an error has ocurred or true if the request was succesfull.

####success?
Check if the request succeed

###Attributes
---

####errors
When the request fails, the errors are stored in this array

#####Example
```ruby
[{ message: 'Bad Request', code: 'BAD_REQUEST' }]
```

#Development

Install the dependencies

```bash
bundle install
```

Run the test suite

```bash
rake test
```
