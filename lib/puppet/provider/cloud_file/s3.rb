require 'aws-sdk-core'
require 'digest/md5'
require File.join(File.dirname(__FILE__), '..', 'cloud_file')

Puppet::Type.type(:cloud_file).provide(:s3, :parent => Puppet::Provider::CloudFile) do
  def create
    write(payload)
  end

  def delete
    File.delete(resource[:path])
  end

  def latest?
    begin
      Digest::MD5.file(resource[:path]).hexdigest != object_summary.etag
    rescue Aws::S3::Errors::InvalidAccessKeyId
      raise Puppet::Error, "Invalid Access Key ID"
    rescue Aws::S3::Errors::SignatureDoesNotMatch
      raise Puppet::Error, "Invalid Access Key ID and/or Secret Access Key"
    rescue Aws::S3::Errors::NoSuchBucket
      raise Puppet::Error, "Bucket Not Found (#{bucket_name})"
    rescue Aws::S3::Errors::NoSuchKey
      raise Puppet::Error, "Remote File Not Found (#{source_path})"
    rescue => e
      raise Puppet::Error, e
    end
  end

  private

  def configure_aws
    if resource[:access_key_id] != :undef && resource[:secret_access_key] != :undef
      Aws.config(:access_key_id => resource[:access_key_id],
                 :secret_access_key => resource[:secret_access_key],
                 :region => resource[:region])
    else
      Aws.config(:regions => resource[:region])
    end
  end

  def s3
    configure_aws
    Aws::S3::Client.new()
  end

  def bucket_name
    resource[:source].split("/").first
  end

  def source_path
    resource[:source].split("/")[1..-1].join("/")
  end

  def object_summary
    s3.head_object(:bucket => bucket_name, :key => source_path)
  end

  def object
    s3.get_object(:bucket => bucket_name, :key=> source_path)
  end

  def write(data)
    begin
      f = File.open(resource[:path], 'w')
    rescue Errno::ENOENT => detail
      raise Puppet::Error, detail.message
    rescue => detail
      p detail
    end

    f.write(data)
    f.close
  end

  def payload
    begin
      object.body
    rescue Aws::S3::Errors::InvalidAccessKeyId
      raise Puppet::Error, "Invalid Access Key ID"
    rescue Aws::S3::Errors::SignatureDoesNotMatch
      raise Puppet::Error, "Invalid Access Key ID and/or Secret Access Key"
    rescue Aws::S3::Errors::NoSuchBucket
      raise Puppet::Error, "Bucket Not Found (#{bucket_name})"
    rescue Aws::S3::Errors::NoSuchKey
      raise Puppet::Error, "Remote File Not Found (#{source_path})"
    rescue => e
      raise Puppet::Error, e
    end
  end
end
