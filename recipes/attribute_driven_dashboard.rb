node['gdash']['dashboards'].each_pair do |dashboard_name, dashboard_config|

  dashboard_category = dashboard_config['category']
  gdash_dashboard dashboard_name do
    display_name dashboard_config['display_name'] if dashboard_config['display_name']
    category dashboard_category
    description dashboard_config['description']
  end

  if dashboard_config['components']
    dashboard_config['components'].each_pair do |component_name, component_config|
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
  end
end

include_recipe "gdash::default"
