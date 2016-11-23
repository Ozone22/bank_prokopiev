class PasswordValidator < ActiveModel::EachValidator
  def validate_each(record, attribute, value)
    return if value =~ /(?=^.{5,}\z)(?=.*[A-Z])(?=.*\d).*\z/
    record.errors[attribute] << (options[:message] || I18n.t('activerecord.errors.attributes.password.wrong_pass'))
  end
end
