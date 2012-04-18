require 'yaml'

def load_current_resource
  node.include_attribute "gdash::gdash"
  node.include_recipe "gdash::default"

  @dashboard_dir = ::File.join(node.gdash.templatedir,
                             new_resource.category,
                             new_resource.name)

  @dashboard_yaml = ::File.join(@dashboard_dir,"dash.yaml")
end

action :create do

  directory @dashboard_dir do
    owner node.gdash.owner
    group node.gdash.group
    notifies :restart, 'service[gdash]', :delayed
  end

  file @dashboard_yaml do
    owner node.gdash.owner
    group node.gdash.group
    content YAML.dump(:name => new_resource.name,
                      :description => new_resource.description)
  end

  new_resource.updated_by_last_action(true)

end

action :delete do

  directory @dashboard_dir do
    action :delete
  end

  file @dashboard_yaml do
    action :delete
  end

  new_resource.updated_by_last_action(true)

end
