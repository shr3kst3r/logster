action :add do
    new_resource.updated_by_last_action(false)

    options = {}

    new_resource.prefix && options["--metric-prefix"] = new_resource.prefix
    new_resource.parser_options && options["--parser-options"] = new_resource.parser_options
    new_resource.gmetric_options && options["--gmetric-options"] = new_resource.gmetric_options
    new_resource.graphite_host && options["--graphite-host"] = new_resource.graphite_host
    new_resource.state_dir && options["--state-dir"] = new_resource.state_dir
    new_resource.output && options["--output"] = new_resource.output

    o = options.map{|k,v| "#{k}=#{v}"}.join(" ")

    cron "logster #{new_resource.log_file.gsub(/\//, '_')}" do
        command "/usr/sbin/logster #{o} #{new_resource.parser} #{new_resource.log_file}"
        action :create
    end
end

action :remove do
    cron "logster #{new_resource.gsub(/\//, '_')}" do
        action :delete
    end
end
