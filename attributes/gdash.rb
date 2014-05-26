#
# Cookbook Name:: gdash
# Attributes:: gdash
#
# Copyright 2013-2014, Heavy Water, Inc
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

default.gdash.tarfile = '/usr/src/gdash.tgz'
default.gdash.base = '/srv/gdash'
default.gdash.url = 'https://github.com/ripienaar/gdash/tarball/master'

####
# WARN: pull in attributes from ANOTHER COOKBOOK
# TODO: put this in a databag ?
####
include_attribute 'graphite::default'
default.gdash.graphite_url = "http://#{ipaddress}:#{graphite[:listen_port]}"
####

default.gdash.templatedir = '/srv/gdash/graph_templates'
default.gdash.owner = 'www-data'
default.gdash.group = 'www-data'
default.gdash.basic_auth = false
default.gdash.username = 'gdash'
default.gdash.password = 'gdash'
default.gdash.title = 'Dashboard'
default.gdash.prefix = nil
default.gdash.refresh_rate = 60
default.gdash.columns = 2
default.gdash.graphite_whisperdb = '/opt/graphite/storage/whisper'
default.gdash.port = 9292
default.gdash.interface = node[:ipaddress]
default.gdash.categories = []
default.gdash.dashboards = Mash.new
