maintainer       "Sean Escriva"
maintainer_email "sean.escriva@gmail.com"
license          "Apache 2.0"
description      "Installs/Configures gdash"
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version          "0.0.1"

%w{debian ubuntu}.each do |os|
  supports os
end

%w{build-essential runit}.each do |dep|
  depends dep
end

depends "iptables"
