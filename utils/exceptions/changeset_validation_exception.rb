# frozen_string_literal: true

## ChangesetValidationException
class ChangesetValidationException < StandardError
  attr_reader :errors

  def initialize(msg, errors)
    @errors = errors
    super(msg)
  end

  def to_s
    print(@errors)
    errs = @errors.join("\n")
    "#{msg}\n---------------\n#{errs}"
  end
end
