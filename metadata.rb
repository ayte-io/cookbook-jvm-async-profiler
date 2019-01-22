name 'ayte-jvm-async-profiler'
maintainer 'Ayte Labs'
maintainer_email 'ops@ayte.team'
license 'MIT'
description 'Installs JVM Async Profiler'
long_description 'Installs JVM Async Profiler'
version '0.1.0'
chef_version '>= 13.0'

source_url 'https://github.com/ayte-io/cookbook-jvm-async-profiler'
issues_url 'https://github.com/ayte-io/cookbook-jvm-async-profiler/issues'

depends :tar, '~> 2.0'

supports :debian, '>= 7'
supports :ubuntu, '>= 16.04'
supports :centos, '>= 6'
supports :opensuse, '>= 42.3'
