# frozen_string_literal: true

module Validation
  def self.included(base)
    base.extend ClassMethods
    base.send(:include, InstanceMethods)
  end

  module ClassMethods
    def validate(attribute, type_validation, *arg)
      @validations ||= {}
      @validations[attribute] ||= []
      @validations[attribute] << [type_validation, arg]
    end
  end

  module InstanceMethods
    def validate!
      self.class.instance_variable_get(:@validations).each do |attr_name, validations|
        validations.each { |v| send("validate_#{v[0]}", attr_name, *v[1]) }
      end
    end

    def valid?
      validate!
    rescue StandardError
      false
    end

    private

    def validate_presence(name)
      return unless send(name.to_s).to_s.empty?
      raise ArgumentError, "#{name} равно nil, или пустой строке!"
    end

    def validate_type(name, type)
      return if send(name.to_s).is_a?(type)
      raise ArgumentError, "#{name} не является классом #{type}!"
    end

    def validate_format(name, format)
      return if send(name.to_s).to_s.match?(format)
      raise ArgumentError, "#{name} не соответстует #{format}"
    end
  end
end
