psource = File.join(Chef::Config[:file_cache_path], "logster.rpm")

remote_file psource do
  source node[:logster][:package][:source]
  checksum node[:logster][:package][:checksum]
  only_if node[:logster][:package][:source]
  notifies :install, "package[logster]", :immediately
end

package "logster" do
  action :nothing
  source psource
end
