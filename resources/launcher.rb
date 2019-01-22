resource_name :jvm_async_profiler_launcher

attribute :path, String, name_property: true
attribute :installation, String, required: true

action_class do
  def converge(action)
    template new_resource.path do
      source 'launcher.sh.erb'
      cookbook 'ayte-jvm-async-profiler'
      mode '0755'
      # noinspection RubyResolve
      variables installation: new_resource.installation
      action action
    end
  end
end

action :create do
  converge(:create)
end

action :remove do
  converge(:delete)
end
