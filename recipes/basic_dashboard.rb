#
# Cookbook Name:: gdash
# Recipe:: basic_dashboard
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
include_recipe 'gdash'

gdash_dashboard 'Base Metrics' do
  category 'Basic'
  description 'Simple dashboard'
end

gdash_dashboard_component 'metrics_received' do
  dashboard_name 'Base Metrics'
  dashboard_category 'Basic'
  vtitle 'Items'
  fields(
    :received => {
      :data => '*.*.*.metricsReceived',
      :alias => 'Metrics Received'
    }
  )
end

gdash_dashboard_component 'cpu' do
  dashboard_name 'Base Metrics'
  dashboard_category 'Basic'
  fields(
    :cpu => {
      :data => '*.*.*.cpuUsage',
      :alias => 'CPU Usage'
    }
  )
end

gdash_dashboard_component 'memory' do
  dashboard_name 'Base Metrics'
  dashboard_category 'Basic'
  fields(
    :memory => {
      :data => '*.*.*.memUsage',
      :alias => 'Memory Usage'
    }
  )
end
