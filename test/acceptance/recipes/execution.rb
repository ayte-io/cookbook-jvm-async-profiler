include_recipe 'ayte-jvm-async-profiler-acceptance::default'

include_recipe 'java::default'
include_recipe 'ayte-jvm-async-profiler::default'

cookbook_file '/tmp/FibonacciGenerator.java'
execute 'javac /tmp/FibonacciGenerator.java'

file '/etc/sysctl.conf' do
  action :touch
end

sysctl 'kernel.perf_event_paranoid' do
  value 1
end

sysctl 'kernel.kptr_restrict' do
  value 0
end

bash 'validate' do
  code <<-COMMAND
    java -cp /tmp FibonacciGenerator > /tmp/result &
    sleep 1
    /usr/local/bin/jvm-async-profiler start -d 30 -f /tmp/graph.svg $!
  COMMAND
end

bash 'wait' do
  code <<-COMMAND
    I=0
    while [[ ! "$I" -eq 30 && ! -z "$(ps aux | grep java | grep -v grep)" ]]; do
      sleep 1;
      I="$(($I + 1))"
    done
  COMMAND
end
