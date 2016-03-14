class EmailValidator < ActiveModel::EachValidator
  EMAIL_REGEXP = /^([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})$/i

  def validate_each(record, attribute, value)
    return unless value.present?
    return if value =~ EMAIL_REGEXP
    record.errors.add(attribute, :invalid)
  end
end
