require "spec_helper"

describe Lyft::API do
  context "With no access token" do
    let(:err_msg) { Lyft::ErrorMessages.no_access_token }

    it "Raises an error" do
      expect{Lyft::API.new}.to raise_error(Lyft::InvalidRequest, err_msg)
    end
  end

  shared_examples "test access token" do
    it "Build a Lyft::API instance" do
      expect(subject).to be_kind_of Lyft::API
    end

    it "Sets the access_token object" do
      expect(subject.access_token).to be_kind_of Lyft::AccessToken
    end

    it "Sets the access_token string" do
      expect(subject.access_token.token).to eq access_token
    end
  end

  context "With a string access token" do
    let(:access_token) { "dummy_access_token" }
    subject {Lyft::API.new(access_token)}

    include_examples "test access token"
  end

  context "With a Lyft::AccessToken object" do
    let(:access_token) { "dummy_access_token" }
    let(:access_token_obj) { Lyft::AccessToken.new(access_token) }

    subject {Lyft::API.new(access_token_obj)}

    include_examples "test access token"
  end
end
