use_inline_resources

action :add do
    require 'shellwords'
    options = Hash.new

    new_resource.prefix && options["--metric-prefix"] = new_resource.prefix
    new_resource.suffix && options["--metric-suffix"] = new_resource.suffix
    new_resource.parser_options && options["--parser-options"] = new_resource.parser_options
    new_resource.gmetric_options && options["--gmetric-options"] = new_resource.gmetric_options
    new_resource.graphite_host && options["--graphite-host"] = new_resource.graphite_host
    new_resource.state_dir && options["--state-dir"] = new_resource.state_dir
    new_resource.output && options["--output"] = new_resource.output

    o = options.map{|k,v| "#{k}=#{v}"}.join(" ")

    cron "logster #{new_resource.log_file.gsub(/\//, '_')}" do
        command "/usr/bin/logster #{o} #{new_resource.parser} '#{Shellwords.escape(new_resource.log_file)}'"
        minute "*/#{new_resource.frequency}"
        action :create
    end
end

action :remove do
    cron "logster #{new_resource.log_file.gsub(/\//, '_')}" do
        action :delete
    end
end
