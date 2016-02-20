require 'active_model'
require 'active_model/serializer'
require 'active_model/serializer_support'
require 'active_model/serializer/version'
require 'active_model/serializer/railtie' if defined?(Rails)

begin
  require 'action_controller'
  require 'action_controller/serialization'
  require 'action_controller/serialization_test_case'

  ActiveSupport.on_load(:action_controller) do
    if ::ActionController::Serialization.enabled
      ActionController::Base.send(:include, ::ActionController::Serialization)
      # we're using this in rails anyway, so it shouldn't be problematic.
      if Rails.env.test?
        ActionController::TestCase.send(:include, ::ActionController::SerializationAssertions)
      end
    end
  end
rescue LoadError
  # rails not installed, continuing
end
