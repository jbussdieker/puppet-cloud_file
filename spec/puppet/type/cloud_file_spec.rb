require 'spec_helper'

describe Puppet::Type.type(:cloud_file) do
  describe "path" do
    it "should have :path be its namevar" do
      described_class.key_attributes.should eq([:path])
    end
  end

  describe "ensure" do
    it "should support present as a value" do
      expect { described_class.new(:path => 'foo', :ensure => :present) }.to_not raise_error
    end

    it "should support absent as a value" do
      expect { described_class.new(:path => 'foo', :ensure => :absent) }.to_not raise_error
    end

    it "should support absent as a value" do
      expect { described_class.new(:path => 'foo', :ensure => :latest) }.to_not raise_error
    end

    it "should not support other values" do
      expect { described_class.new(:path => 'foo', :ensure => :foo) }.to raise_error(Puppet::Error, /Invalid value/)
    end
  end

  describe "source" do
    it "should support strings as a value" do
      expect { described_class.new(:path => 'foo', :source => 'bucket/path/to/file') }.to_not raise_error
    end
  end

  describe "access_key_id" do
    it "should support strings as a value" do
      expect { described_class.new(:path => 'foo', :access_key_id => 'ACCESS_KEY_ID') }.to_not raise_error
    end

    it "should have :undef as a default value" do
      described_class.new(:path => 'foo')[:access_key_id].should eq(:undef)
    end
  end

  describe "access_key_id" do
    it "should support strings as a value" do
      expect { described_class.new(:path => 'foo', :secret_access_key => 'SECRET_ACCESS_KEY') }.to_not raise_error
    end

    it "should have :undef as a default value" do
      described_class.new(:path => 'foo')[:secret_access_key].should eq(:undef)
    end
  end
  describe "region" do
    it "should support strings as a value" do
      expect { described_class.new(:path => 'foo', :region => 'REGION') }.to_not raise_error
    end

    it "should have us-east-1 as a default value" do
      described_class.new(:path => 'foo')[:region].should eq('us-east-1')
    end
  end
end
