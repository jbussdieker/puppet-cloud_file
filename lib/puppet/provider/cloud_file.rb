class Puppet::Provider::CloudFile < Puppet::Provider
  def exists?
    File.exists? resource[:path]
  end
end
