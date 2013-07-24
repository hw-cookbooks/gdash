include_recipe "gdash::default"

node['gdash']['dashboards'].each_pair do |dashboard_name, dashboard_config|

  dashboard_category = dashboard_config['category']
  gdash_dashboard dashboard_name do
    display_name dashboard_config['display_name'] if dashboard_config['display_name']
    category dashboard_category
    description dashboard_config['description']
  end

  components = dashboard_config['components'] || {}

  components.each_pair do |component_name, component_config|
    gdash_dashboard_component component_name do
      dashboard_name dashboard_name
      dashboard_category dashboard_category
      (::GDASH_RESOURCE_ATTRIBS + %w(forecasts fields)).each do |key|
        if 'dashboard_name' == key
          dashboard_name dashboard_name
        elsif 'dashboard_category' == key
          dashboard_category dashboard_category
        elsif 'area' == key
          area component_config[key].to_sym if component_config[key]
        elsif 'fields' == key
          if component_config[key]
            fields = {}
            component_config[key].each_pair do |key, value|
              new_values = {}
              value.each_pair do |k, v|
                new_values[k.to_sym] = v
              end
              fields[key.to_sym] = new_values
            end
            fields fields
          end
        else
          send(key.to_sym, component_config[key]) if component_config[key]
        end
      end
    end
  end

  template_dir = "#{node['gdash']['templatedir']}/#{dashboard_category}/#{dashboard_name}"
  ::Dir.entries(template_dir).each do |entry|
    graph_file = "#{template_dir}/#{entry}"
    if ::File.file?(graph_file) && graph_file =~ /.*\.graph$/ && !components.keys.include?(File.basename(entry, ".graph"))
      file graph_file do
        action :delete
        backup false
        notifies :restart, resources(:service => 'gdash'), :delayed
      end
    end
  end if File.exist?(template_dir)

end

categories = node['gdash']['dashboards'].values.collect { |dashboard_config| dashboard_config['category'] }
::Dir.entries(node['gdash']['templatedir']).each do |category|
  if category != '.' && category != '..'
    category_dir = "#{node['gdash']['templatedir']}/#{category}"
    if categories.include?(category)
      ::Dir.entries(category_dir).each do |entry|
        dashboard_dir = "#{category_dir}/#{entry}"
        if ::File.directory?(dashboard_dir) && entry != '.' && entry != '..' && (node['gdash']['dashboards'][entry].nil? || category != node['gdash']['dashboards'][entry]['category'])
          directory dashboard_dir do
            action :delete
            recursive true
            notifies :restart, resources(:service => 'gdash'), :delayed
          end
        end
      end
    else
      directory category_dir do
        action :delete
        recursive true
        notifies :restart, resources(:service => 'gdash'), :delayed
      end
    end
  end
end if File.exist?(node['gdash']['templatedir'])
