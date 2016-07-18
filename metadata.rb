name ::File.read(::File.join(::File.dirname(::File.join(__FILE__)), 'NAME')).strip
maintainer 'Luis De Siqueira'
maintainer_email 'LouTheBrew@gmail.com'
license 'MIT'
description 'Installs/Configures runit'
long_description 'Installs/Configures runit'
#version ::File.read(::File.join(::File.dirname(::File.join(__FILE__)), 'VERSION'))
version '0.1.1'

depends 'build-essential'
depends 'poise'
depends 'eldus-ruby-init'
