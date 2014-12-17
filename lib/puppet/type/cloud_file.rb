Puppet::Type.newtype(:cloud_file) do
  desc 'A cloud based file'

  ensurable do
    defaultto :present

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
  end

  newparam(:access_key_id) do
    desc 'The AWS access key to connect to S3.'
    defaultto :undef
  end

  newparam(:secret_access_key) do
    desc 'The AWS secret access key to connect to S3.'
    defaultto :undef
  end
end
