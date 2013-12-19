file "/usr/bin/logster" do
    backup false
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
