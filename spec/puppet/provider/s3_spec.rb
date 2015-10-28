require 'spec_helper'
require 'tempfile'
require 'digest/md5'

file = Tempfile.new('foo')
path = file.path
describe Puppet::Type.type(:cloud_file).provider(:s3) do

  let(:name) { 'myS3File'}
  let(:resource) do
    Puppet::Type.type(:cloud_file).new(
      :name => path,
      :source => 'hiera.bamgrid.net/appversion/coreeng/prod/mlbam/zach-dev/default.yaml',
      :ensure => :latest,
      :provider => :s3,
      )
  end

  let(:provider) do
    described_class.new(resource)
  end
  
  # provider shoudl respond to the followign methods
  [:create, :delete, :latest?].each do |method|
    it "should have a(n) #{method}" do
      expect(provider).to respond_to(method)
    end
  end

  describe "#create" do
    before do
      aws_stub = Aws::S3::Client.new(:region => 'us-east-1', :stub_responses => true)
      provider.stubs(:s3).returns(aws_stub)
    end

    it "should create file" do
      provider.expects(:create)
      provider.create
    end
  end
  describe "#latest is true" do
    before do
      aws_stub = Aws::S3::Client.new(:region => 'us-east-1', :stub_responses => true)
      aws_stub.stub_responses(:head_object, {:etag => Digest::MD5.file(file.path).hexdigest})
      provider.stubs(:s3).returns(aws_stub)
    end

    it "should return true " do
      latest = provider.latest?
      expect(latest).to eq true
    end
  end
  describe "#latest is false" do
    before do
      aws_stub = Aws::S3::Client.new(:region => 'us-east-1', :stub_responses => true)
      aws_stub.stub_responses(:head_object, {:etag => '1123'})
      provider.stubs(:s3).returns(aws_stub)
    end

    it "should return false " do
      latest = provider.latest?
      expect(latest).to eq false
    end
  end
  describe "#create" do
    before do
      aws_stub = Aws::S3::Client.new(:region => 'us-east-1', :stub_responses => true)
      aws_stub.stub_responses(:get_object, {:body => 'test-body'})
      provider.stubs(:s3).returns(aws_stub)
    end

    it "lay contents down" do
      provider.create
      expect(file.read).to eq "test-body"
    end
  end
   describe "#delete" do
    before do
      path  = file.path
    end
    it "delete file" do
      provider.delete
      expect(File.exist?(path)).to eq false
    end
  end

  after(:all) do
    file.close
    file.unlink
  end
end
