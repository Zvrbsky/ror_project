# Class wasn't written by ourselves, but only modified. Source: https://gist.github.com/carlosramireziii/73f2c7b12dd6716482e41a3cd8e0a94d#file-attached_validator-rb

class AttachedValidator < ActiveModel::EachValidator
  def validate_each(record, attribute, value)
    record.errors.add(attribute, ' cannot be empty') unless value.attached?
  end
end
