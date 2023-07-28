# frozen_string_literal: true

module Accessor
  def self.included(base)
    base.extend ClassMethods
  end

  module ClassMethods
    def attr_accessor_with_history(*names)
      names.each do |name|
        var_name = "@#{name}".to_sym
        define_method(name) { instance_variable_get(var_name) }

        define_method("#{name}=".to_sym) do |attr_value|
          instance_variable_set(var_name, attr_value)
          @history ||= Hash.new { |key, value| key[value] = [] }
          @history[var_name] << attr_value
        end

        define_method("#{name}_history".to_sym) { @history[var_name] }
      end
    end

    def strong_attr_acessor(attr_name, argument_class)
      var_name = "@#{attr_name}".to_sym
      define_method(attr_name) { instance_variable_get(var_name) }

      define_method("#{attr_name}=".to_sym) do |value|
        raise ArgumentError, 'Class is incorrect!' unless attr_name.is_a?(argument_class)

        instance_variable_set(var_name, value)
      end
    end
  end
end
