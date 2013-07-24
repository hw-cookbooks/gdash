Description
===========

Cookbook to automatically deploy the Gdash web interface for
Graphite.

Requirements
============

## Platform:

 * Debian/Ubuntu

## Cookbooks

 * build-essentials
 * runit

Attributes
==========

 See `attributes/default.rb` for defaults.

 * `node['gdash']['graphite_whisperdb']` - Full path to graphite
   database
 * `node['gdash']['templatedir']` - Full path to graph templates
 * `node['gdash']['dashboards']` - Attributes defining the set of dashboards.

Usage
=====

This cookbook currently sets up gdash and a basic runit service.
Graph creation is left to the user.

Graph Creation
==============

Dashboard creation
------------------

First create a dashboard:

```ruby

gdash_dashboard 'cpu_usage' do
  category 'metrics'
  description 'CPU Usages'
end
```

Dashboard component creation
----------------------------

Next, add components to the dashboard. Dashboards are referenced by
their name and category when adding components:

```ruby

gdash_dashboard_component 'node1' do
  dashboard_name 'cpu_usage'
  dashboard_category 'metrics'
  linemode 'slope'
  description 'Node1 CPU usage'
  fields(
    :system => {
      :scale => 0.001,
      :color => 'orange',
      :alias => 'System Usage 0',
      :data => 'node1.cpu.0.system.value'
    },
    :user => {
      :scale => 0.001,
      :color => 'blue',
      :alias => 'User Usage 0',
      :data => 'node1.cpu.0.user.value'
    }
  )
end
```


Dashboard creation via attributes
---------------------------------

Alternatively attributes can be used to define the set of dashboards
and the `attribute_driven_dashboard` recipe can be used to managed the
dashboards. The recipe will remove categories, dashboards and dashboard
components that no longer exist and create all those as specified in
attributes. For example:

```ruby

node.override['gdash']['dashboards']['cpu_usage'] =
  {
    'category' => 'metrics',
    'description' => 'CPU Usages of the nodes across the cluster',
    'display_name' => 'CPU Usages',
    'components' => {
      'node1' => {
        'linemode' => 'slope',
        'description' => 'Node1 CPU usage',
        'fields' => {
            :system => {
              :scale => 0.001,
              :color => 'orange',
              :alias => 'System Usage 0',
              :data => 'node1.cpu.0.system.value'
            },
            :user => {
              :scale => 0.001,
              :color => 'blue',
              :alias => 'User Usage 0',
              :data => 'node1.cpu.0.user.value'
            }
        }
      }
    }
  }
end
```

