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

    # def valid?
    #   @number =~ /^[a-z|\d]{3}$|[a-z|\d]{3}-{1}[a-z|\d]{2}$/
    # end

    # def validate!
    #   raise ArgumentError, 'Train number is invalid' unless valid?
    # end

    private

    def validate_presence(name)
      raise ArgumentError, "#{name} равно nil, или пустой строке!" if send(name.to_s).to_s.empty?
    end

    def validate_type(name, type)
      raise ArgumentError, "#{name} не является классом #{type}!" unless send(name.to_s).is_a?(type)
    end

    def validate_format(name, format)
      raise ArgumentError, "#{name} не соответстует #{format}" if send(name.to_s).to_s !~ format
    end
  end
end

# class Train
#   validate(:name, :exist)
#   validate(:name, :format, /dd/)
# end

# send("validate_#{v[0]}", attr_name, *v[1])
# validate_presend(:name, nil)
