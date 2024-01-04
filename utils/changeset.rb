# frozen_string_literal: true

require_relative './exceptions/changeset_validation_exception'

## Changeset
module Changeset
  ## Validate
  class Validate
    def initialize(obj)
      @obj = obj
    end

    def call
      @obj
    end

    def cast(fields)
      @obj = fields.each_with_object({}) do |field, result|
        result[field] = @obj[field] if @obj[field]
      end
      self
    end

    def required(fields)
      required_fields = []
      fields.each_with_object({}) do |field, _result|
        required_fields.push(field) unless @obj[field]
      end

      return self if required_fields.empty?

      raise ChangesetValidationException.new('Fail required fields', required_fields)
    end
  end
end
