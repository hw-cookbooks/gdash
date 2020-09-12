name             'gdash'
maintainer       'Heavy Water Software Inc.'
maintainer_email 'ops@hw-ops.com'
license          'Apache-2.0'
description      'Installs/Configures gdash'
version          '0.1.0'

supports 'debian'
supports 'ubuntu'

%w(build-essential runit graphite unicorn).each do |dep|
  depends dep
end
