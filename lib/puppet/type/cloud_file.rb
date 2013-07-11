Puppet::Type.newtype(:cloud_file) do
  desc "A cloud based file"

  ensurable do
    newvalue :present do
      provider.create
    end

    newvalue :absent do
      provider.delete
    end

    def retrieve
      if provider.exists?
        :present
      else
        :absent
      end
    end
  end

  newparam(:path) do
    desc "The local path for the destination file."
    isnamevar
  end

  newparam(:source) do
    desc "Specify the source url of the cloud file ex (bucket_name/path/to/file)."
  end

  newparam(:access_key_id) do
    desc "The AWS access key to connect to S3."
  end

  newparam(:secret_access_key) do
    desc "The AWS secret access key to connect to S3."
  end
end
