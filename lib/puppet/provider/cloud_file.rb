class Puppet::Provider::CloudFile < Puppet::Provider
  def exists?
    File.exists? @resource.value(:path)
  end
end
