Puppet::Type.newtype(:cloud_file) do
  desc 'A cloud based file'

  ensurable do
    newvalue :present do
      provider.create
    end

    newvalue :absent do
      provider.delete
    end

    newvalue :latest do
      provider.create
    end

    def retrieve
      if provider.exists?
        if value == :latest and provider.latest?
          :latest
        else
          :present
        end
      else
        :absent
      end
    end
  end

  newparam(:path) do
    desc 'The local path for the destination file.'
    isnamevar
  end

  newparam(:source) do
    desc 'The source of the cloud file (e.g. bucket_name/path/to/file).'
    validate do |v|
      unless v.include? "/"
        raise ArgumentError, "%s is not a valid source path, please include bucket_name/path/to/file" % value
      end
    end
  end

  newparam(:access_key_id) do
    desc 'The AWS access key to connect to S3.'
    defaultto :undef
  end

  newparam(:secret_access_key) do
    desc 'The AWS secret access key to connect to S3.'
    defaultto :undef
  end

  newparam(:region) do
    desc 'The region bucket is in'
    defaultto 'us-east-1'
  end
end
