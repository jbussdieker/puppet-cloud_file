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
    isnamevar
  end

  newparam(:source)
  newparam(:access_key_id)
  newparam(:secret_access_key)
end
