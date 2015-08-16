require File.expand_path('../test_helper', __FILE__)

class LeadTest < Minitest::Test
  def setup
    @lead = Salesforce::Lead.new({
      last_name: 'Doe',
      email: 'john@doe.com',
      company: 'Foo Bar Inc.',
      job_title: 'Developer',
      phone: '55011998012345',
      website: 'http://johndoe.com'
    }, { token: 'Token123ABC', instance_url: 'http://n123.salesforce.com' })
  end

  def test_that_last_name_is_set
    assert_equal 'Doe', @lead.last_name
  end

  def test_that_email_is_set
    assert_equal 'john@doe.com', @lead.email
  end

  def test_that_company_is_set
    assert_equal 'Foo Bar Inc.', @lead.company
  end

  def test_that_job_title_is_set
    assert_equal 'Developer', @lead.job_title
  end

  def test_that_phone_is_set
    assert_equal '55011998012345', @lead.phone
  end

  def test_that_website_is_set
    assert_equal 'http://johndoe.com', @lead.website
  end

  def test_that_credentials_is_set
    assert_equal({ token: 'Token123ABC', instance_url: 'http://n123.salesforce.com' }, @lead.credentials)
  end

  def test_create_failure
    stub_request(:post, @lead.create_url)
      .with(headers: @lead.auth_header, body: @lead.to_json)
      .to_return(
        status: 400, headers: { content_type: 'application/json' },
        body: [{ message: 'Bad Request', errorCode: 'BAD_REQUEST' }].to_json
      )

    assert_equal false, @lead.create
    assert_equal false, @lead.success?
    assert_equal [{ message: 'Bad Request', code: 'BAD_REQUEST' }], @lead.errors
  end

  def test_create_success
    stub_request(:post, @lead.create_url)
      .with(headers: @lead.auth_header, body: @lead.to_json)
      .to_return(status: 201, headers: { content_type: 'application/json' })

    assert_equal true, @lead.create
    assert_equal true, @lead.success?
  end

  def test_create_url
    assert_equal 'http://n123.salesforce.com/services/data/v29.0/sobjects/Lead/', @lead.create_url
  end

  def test_auth_header
    assert_equal({ 'Authorization' => 'Bearer Token123ABC' }, @lead.auth_header)
  end

  def test_to_json
    assert_equal({
      'LastName' => 'Doe',
      'Email' => 'john@doe.com',
      'Company' => 'Foo Bar Inc.',
      'Title' => 'Developer',
      'Phone' => '55011998012345',
      'Website' => 'http://johndoe.com'
    }.to_json, @lead.to_json)
  end
end