package "git"

if platform_family?("rhel")
    package "logcheck"
else
    package "logtail"
end

git 'logster' do
    repository "https://github.com/etsy/logster.git"
    destination "/var/tmp/logster"
    reference node[:logster][:version]
    notifies :run, 'execute[create logster]'
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
    command "/usr/bin/install -m 0755 -t /usr/sbin /var/tmp/logster/bin/logster"
    creates "/usr/sbin/logster"
end

execute "create logster_helper" do
    command "/usr/bin/install -m 0644 -t /usr/share/logster /var/tmp/logster/logster/logster_helper.py"
    creates "/usr/share/logster/logster_helper.py"
end

if File.exists?("/var/tmp/logster/logster/parsers") then
    Dir.foreach("/var/tmp/logster/logster/parsers") do |fname|
        next if fname == '.' or fname == '..'
        file "/usr/share/logster/#{fname}" do
            content IO.read("/var/tmp/logster/logster/parsers/#{fname}")
            owner "root"
            group "root"
            mode "0644"
        end
    end
end
