require 'aws-sdk'
require File.join(File.dirname(__FILE__), '..', 'cloud_file')

Puppet::Type.type(:cloud_file).provide(:s3, :parent => Puppet::Provider::CloudFile) do
  def create
    File.open(resource[:path], 'w') do |f|
      f.write(object.read)
    end
  end

  private

  def s3
    AWS::S3.new(
      :access_key_id => resource[:access_key_id],
      :secret_access_key => resource[:secret_access_key]
    )
  end

  def bucket
    bucket = resource[:source].split("/").first
    s3.buckets[bucket]
  end

  def object
    path = resource[:source].split("/")[1..-1].join("/")
    bucket.objects[path]
  end
end
