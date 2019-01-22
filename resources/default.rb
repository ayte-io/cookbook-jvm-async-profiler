resource_name :jvm_async_profiler

attribute :path, name_property: true
attribute :version, [String, Symbol], default: '1.5'
attribute :launcher, [String, NilClass]

action_class do
  # noinspection RubyResolve
  def converge(action)
    jvm_async_profiler_installation new_resource.path do
      version new_resource.version
      action action
    end
    return if new_resource.launcher.nil?
    jvm_async_profiler_launcher new_resource.launcher do
      installation new_resource.path
      action action
    end
  end
end

action :create do
  converge(:create)
end

action :remove do
  converge(:remove)
end
