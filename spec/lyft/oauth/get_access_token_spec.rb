require "spec_helper"

describe "Get OAuth2 Access Token" do
  code = "dummy_code"
  client_id = "dummy_client_id"
  client_secret = "dummy_client_secret"
  redirect_uri = "http://lvh.me:5000"

  before(:example) do
    Lyft.configure do |config|
      config.client_id     = client_id
      config.client_secret = client_secret
    end
  end
  subject { Lyft::OAuth2.new }

  shared_examples "Success Access Token Fetch" do |*args|
    it "Returns an access token object" do
      VCR.use_cassette("access token success") do
        expect(subject.get_access_token(*args)).to be_kind_of Lyft::AccessToken
      end
    end

    it "Sets the AcessToken object" do
      VCR.use_cassette("access token success") do
        subject.get_access_token(*args)
        expect(subject.access_token).to be_kind_of Lyft::AccessToken
      end
    end

    it "Generated an access token string" do
      VCR.use_cassette("access token success") do
        subject.get_access_token(*args)
        expect(subject.access_token.token).to be_kind_of String
      end
    end
  end

  shared_examples "Raises InvalidRequest" do |*args|
    it "Raises InvalidRequest" do
      expect{subject.get_access_token(*args)}.to raise_error(Lyft::InvalidRequest, msg)
    end

    it "Has no AccessToken object set" do
      expect(subject.access_token).to be_nil
    end
  end
end
