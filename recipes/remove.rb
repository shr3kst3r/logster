file "/usr/bin/logster" do
    action :delete
end

directory "/usr/share/logster" do
    recursive true
    action :delete
end

directory "/var/tmp/logster" do
    recursive true
    action :delete
end
