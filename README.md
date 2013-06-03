Description
===========

Cookbook to automatically deploy the Gdash web interface for
Graphite. Resources are provided for automated graph and dashboard
creation.

Requirements
============

## Platform:

 * Debian
 * Ubuntu

## Cookbooks

 * build-essentials
 * runit
 * graphite
 * unicorn
 * optional dependency: iptables

Attributes
==========

 * `node['gdash']['tarfile']` - Full path to store downloaded tgz
 * `node['gdash']['base']` - Full path for gdash root
 * `node['gdash']['url']` - Download url for gdash tarball
 * `node['gdash']['templatedir']` - Dashboard template directory
 * `node['gdash']['owner']` - User gdash runs as
 * `node['gdash']['group']` - Group permission for gdash
 * `node['gdash']['basic_auth']` - Toggle basic auth setting for
   dashboard access
 * `node['gdash']['username']` - Basic auth username
 * `node['gdash']['password']` - Basic auth password
 * `node['gdash']['title']` - Dashboard main title
 * `node['gdash']['refresh_rate']` - Refresh rate
 * `node['gdash']['columns']` - Number of columns
 * `node['gdash']['graphite_whisperdb']` - Full path to graphite
   whisper database
 * `node['gdash']['port']` - Port gdash is available on
 * `node['gdash']['categories']` - Categories to group dashboards into

Resources
=========

  * gdash_dashboard - Create a dashboard with a category and description
  * gdash_dashboard_component - Create a graph and add it to a dashboard

Recipes
=======

default
-------

The default recipe performs basic setup of gdash and creates a runit
service definition.

firewall
--------

The firewall recipe uses iptables to open ports for the dashboard.
This is optional and requires the iptables cookbook if used.

basic_dashboard
---------------

The basic_dashboard recipe is intended an example to get up and
running with gdash and automatic graph creation. Use this recipe and
the usage description to get started building your own dashboards with
the resources provided by this cookbook.

Usage
=====

Graph creation is left to the user but an recipe is provided to
create a basic dashboard and provide usage examples.

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

