include_recipe "git"

package "logtail"

execute "git checkout logster" do
    command "git clone https://github.com/etsy/logster.git"
    creates "/var/tmp/logster"
    cwd "/var/tmp"
    action :run
end

directory "/usr/share/logster" do
    owner "root"
    group "root"
    mode "0755"
end

directory "/var/log/logster" do
    owner "root"
    group "root"
    mode "0755"
end

execute "create logster" do
    command "/usr/bin/install -m 0755 -t /usr/sbin /var/tmp/logster/logster"
    creates "/usr/sbin/logster"
end

execute "create logster_helper" do
    command "/usr/bin/install -m 0644 -t /usr/share/logster /var/tmp/logster/logster_helper.py"
    creates "/usr/share/logster/logster_helper.py"
end

if File.exists?("/var/tmp/logster/parsers") then
    Dir.foreach("/var/tmp/logster/parsers") do |fname|
        next if fname == '.' or fname == '..'
        file "/usr/share/logster/#{fname}" do
            content IO.read("/var/tmp/logster/parsers/#{fname}")
            owner "root"
            group "root"
            mode "0644"
        end
    end
end
