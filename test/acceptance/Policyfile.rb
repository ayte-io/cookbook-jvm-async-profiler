# Policyfile.rb - Describe how you want Chef to build your system.
#
# For more information on the Policyfile feature, visit
# https://docs.chef.io/policyfile.html

# A name that describes what the system you're building with Chef does.
name 'ayte-jvm-async-profiler-acceptance'

# Where to find external cookbooks:
default_source :supermarket

# run_list: chef-client will run these recipes in the order specified.
run_list 'ayte-jvm-async-profiler-acceptance::default'

named_run_list :update, 'ayte-jvm-async-profiler-acceptance::update'
named_run_list :execution, 'ayte-jvm-async-profiler-acceptance::execution'

# Specify a custom source for a single cookbook:
cookbook 'ayte-jvm-async-profiler-acceptance', path: '.'
cookbook 'ayte-jvm-async-profiler', path: '../..'
