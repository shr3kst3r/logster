psource = File.join(Chef::Config[:file_cache_path], "logster.rpm")

if node[:logster][:package][:source]
  remote_file psource do
    source node[:logster][:package][:source]
    checksum node[:logster][:package][:checksum]
    notifies :install, "package[logster]", :immediately
  end
end


package "logster" do
  action :nothing if node[:logster][:package][:source]
  source psource if node[:logster][:package][:source]
end
