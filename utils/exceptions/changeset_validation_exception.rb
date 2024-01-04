# frozen_string_literal: true

## ChangesetValidationException
class ChangesetValidationException < StandardError
  attr_reader :errors

  def initialize(msg, errors)
    @errors = errors
    super(msg)
  end
end
