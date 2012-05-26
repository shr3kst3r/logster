actions :add, :remove

def initialize(*args)
    super
    @action = :add
end

attribute :log_file, :kind_of => String, :name_attribute => true
attribute :prefix, :kind_of => String
attribute :parser_options, :kind_of => String
attribute :gmetric_options, :kind_of => String
attribute :graphite_host, :kind_of => String
attribute :state_dir, :kind_of => String
attribute :output, :kind_of => String
attribute :parser, :kind_of => String
