default.gdash.tarfile = "/usr/src/gdash.tgz"
default.gdash.base = "/srv/gdash"
default.gdash.url = "https://github.com/ripienaar/gdash/tarball/master"

####
# WARN: pull in attributes from ANOTHER COOKBOOK
# TODO: put this in a databag ?
####
include_attribute "graphite::default"
default.gdash.graphite_url = "http://#{ipaddress}:#{graphite[:listen_port]}"
####

default.gdash.templatedir = "/srv/gdash/graph_templates"
default.gdash.owner = "www-data"
default.gdash.group = "www-data"
default.gdash.basic_auth = false
default.gdash.username = "gdash"
default.gdash.password = "gdash"
default.gdash.title = "Dashboard"
default.gdash.prefix = nil
default.gdash.refresh_rate = 60
default.gdash.columns = 2
default.gdash.graph_width = 500
default.gdash.graph_height = 250
default.gdash.graphite_whisperdb = "/opt/graphite/storage/whisper"
default.gdash.port = 9292
default.gdash.interface = node[:ipaddress]
default.gdash.categories = []
default.gdash.dashboards = Mash.new
default.gdash.interval_filters = [ { label: "Last Hour", from: "-1hour", to: "now" },
                                   { label: "Last Day", from: "-1day", to: "now" },
                                   { label: "Last Week", from: "-1week", to: "now" },
                                   { label: "Last Month", from: "-1month", to: "now" },
                                   { label: "Last Year", from: "-1year" }, to: "now" ]
default.gdash.intervals = [ { label: "1 hour", from: "-1hour" },
                            { label: "2 hour", from: "-2hour" },
                            { label: "1 day", from: "-1day" },
                            { label: "1 month", from: "-1month" },
                            { label: "1 year", from: "-1year" } ]
