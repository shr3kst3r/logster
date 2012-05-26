include_recipe "git"

package "logtail"

execute "git checkout logster" do
    command "git clone https://github.com/etsy/logster.git"
    creates "/tmp/logster"
    cwd "/tmp"
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
    command "/usr/bin/install -m 0755 -t /usr/sbin /tmp/logster/logster"
    creates "/usr/sbin/logster"
end

execute "create logster_helper" do
    command "/usr/bin/install -m 0644 -t /usr/share/logster /tmp/logster/logster_helper.py"
    creates "/usr/share/logster/logster_helper.py"
end

if File.exists?("/tmp/logster/parsers") then
    Dir.foreach("/tmp/logster/parsers") do |fname|
        next if fname == '.' or fname == '..'
        file "/usr/share/logster/#{fname}" do
            content IO.read("/tmp/logster/parsers/#{fname}")
            owner "root"
            group "root"
            mode "0644"
        end
    end
end
