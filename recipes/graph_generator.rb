#
# Cookbook Name:: gdash
# Recipe:: graph_generator
#
# Copyright 2012, Sean Escriva <sean.escriva@gmail.com>
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

include_recipe "gdash::default"

test_dashboards = [
                   {
                     :name => "test",
                     :category => "bob",
                     :description => "bob's testing your uncle"
                   }
                  ]

test_dashboards.each do |dashboard|
  unless node.gdash.categories.include? dashboard[:category]
    node.gdash.categories = (node.gdash.categories | [dashboard[:category]] )
  end
end

node.gdash.categories.map do |category|
  directory File.join(node.gdash.templatedir, category) do
    owner node.gdash.owner
    group node.gdash.group
    notifies :restart, resources(:service => "gdash"), :delayed
  end
end

test_dashboards.each do |dashboard|
  Chef::Log.debug "gdash_dashboard: going to create #{dashboard.inspect}"

  gdash_dashboard dashboard[:name] do
    category dashboard[:category]
    description dashboard[:description]
  end
end

