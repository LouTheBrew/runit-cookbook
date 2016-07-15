name ::File.read(::File.join(::File.dirname(::File.join(__FILE__)), 'NAME'))
maintainer 'Luis De Siqueira'
maintainer_email 'LouTheBrew@gmail.com'
license 'MIT'
description 'Installs/Configures runit'
long_description 'Installs/Configures runit'
version ::File.read(::File.join(::File.dirname(::File.join(__FILE__)), 'VERSION'))

depends 'build-essential'
depends 'poise'
depends 'eldus-ruby-init'
