default_action :create

actions :create, :delete

attribute :category, kind_of: String, required: true
attribute :description, kind_of: String, required: true
attribute :display_name, kind_of: String, required: false
attribute :graph_properties, kind_of: Hash, required: false
