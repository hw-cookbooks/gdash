maintainer       "Heavy Water Software Inc."
maintainer_email "ops@hw-ops.com"
license          "Apache 2.0"
description      "Installs/Configures gdash"
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version          "0.0.2"

recipe  "gdash", "Main gdash setup and service configuration"
recipe  "gdash::firewall", "Iptables rules. Optional, iptables cookbook required"
recipe  "gdash::basic_dashboard", "Sets up simple dashboard, example LWRP usage"

%w{ debian ubuntu }.each do |os|
  supports os
end

%w{ build-essential runit graphite unicorn }.each do |dep|
  depends dep
end

suggests "iptables"

attribute "gdash/tarfile",
  :display_name => "Gdash tarfile",
  :description => "Full path to store downloaded tgz",
  :default => "/usr/src/gdash.tgz"

attribute "gdash/base",
  :display_name => "Gdash base",
  :description => "Full path for gdash root",
  :default => "/srv/gdash"

attribute "gdash/url",
  :display_name => "Gdash URL",
  :description => "Download url for gdash tarball",
  :default => "https://github.com/ripienaar/gdash/tarball/master"

attribute "gdash/templatedir",
  :display_name => "Gdash template directory",
  :description => "Dashboard template path",
  :default => "/srv/gdash/graph_templates"

attribute "gdash/owner",
  :display_name => "Gdash owner",
  :description => "User gdash runs as",
  :default => "www-data"

attribute "gdash/group",
  :display_name => "Gdash group",
  :description => "Group permission for gdash",
  :default => "www-data"

attribute "gdash/basic_auth",
  :display_name => "Basic auth enable",
  :description => "Toggle basic auth setting for dashboard access",
  :default => "false"

attribute "gdash/username",
  :display_name => "Basic auth username",
  :description => "Username, if using basic auth",
  :default => "gdash"

attribute "gdash/password",
  :display_name => "Basic auth password",
  :description => "Password, if using basic auth",
  :default => "gdash"

attribute "gdash/title",
  :display_name => "Dashboard main title",
  :description => "Title displayed on dashboard site",
  :default => "Dashboard"

attribute "gdash/refresh_rate",
  :display_name => "Refresh Rate",
  :description => "Refresh rate for graphs",
  :default => "60"

attribute "gdash/columns",
  :display_name => "Number of columns",
  :description => "Number of columns on a dashboard",
  :default => "2"

attribute "gdash/graphite_whisperdb",
  :display_name => "Graphite Whisperdb path",
  :description => "Full path to graphite whisper database",
  :default => "/opt/graphite/storage/whisper"

attribute "gdash/port",
  :display_name => "Gdash Port",
  :description => "Port gdash is available on",
  :default => "9292"

attribute "gdash/categories",
  :display_name => "Dashboard Categories",
  :description => "Categories to group Dashboards into",
  :default => "",
  :type => "array"
