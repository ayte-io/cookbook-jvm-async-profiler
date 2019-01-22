# JVM Async Profiler cookbook

This cookbook helps to install glorious 
[JVM Async Profiler][jvm-async-profiler].

## Recipe aka 'just do it for me'

`ayte-jvm-async-profiler::default` recipe will automatically install
latest available profiler version in
`/usr/local/share/jvm-async-profiler` directory and create
`/usr/local/bin/jvm-async-profiler` launcher script.

By default it installs latest known version (1.5 at the moment of 
writing), which is configured through 
`['ayte']['jvm-async-profiler']['version']` attribute.

This cookbook relies on [tar cookbook][tar-cookbook] and performs 
extraction during installation process. End user is responsible for 
installing tar/gzip.

## Resources

### jvm_async_profiler

Installs profiler in specified directory and optionally creates a
launcher script at `executable` location.

Since `profiler.sh` relies on current executable location, symlinking 
directly breaks it, so launcher script is created instead of symlink.

| property | description |
|:---------|:------------|
| path     | Name property, path to directory in which profiler will be installed
| version  | Profiler version to install, optional
| launcher | Location for launcher script, optional

### jvm_async_profiler_installation

Supplemental resource that allows to have several installations wherever
you want if you need to.

| property | description |
|:---------|:------------|
| path     | Name property, path to directory in which profiler will be installed
| version  | Profiler version to install, optional

### jvm_async_profiler_launcher

Supplemental resource that allows to have as many launchers as you need.

| property     | description |
|:-------------|:------------|
| path         | Name property, path to launcher location
| installation | Path to directory profiler is installed in

## Notes

Profiler usage requires sysctl tuning, which is not done automatically:

```ruby
sysctl 'kernel.perf_event_paranoid' do
  value 1
end

sysctl 'kernel.kptr_restrict' do
  value 0
end
```

## Licensing

Ayte Labs, 2019 / MIT License / Feel free to play as you wish.

[JVM Async Profiler][jvm-async-profiler] is licensed separately under
Apache License 2.0. This cookbook provides only means to install it and
nothing beyond that.

  [jvm-async-profiler]: https://github.com/jvm-profiling-tools/async-profiler
  [tar-cookbook]: https://supermarket.chef.io/cookbooks/tar
