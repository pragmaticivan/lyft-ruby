require 'spec_helper'

describe Lyft do
  it "is a module" do
    expect(Lyft).to be_a Module
  end

  it "is independently loadable" do
    expect { require 'lyft' }.not_to raise_error
  end

  describe Lyft::OAuth2 do
    it "is a class" do
      expect(Lyft::OAuth2).to be_a Class
    end
  end

  describe Lyft::API do
    it "is a class" do
      expect(Lyft::API).to be_a Class
    end
  end
end
