class DateRangeValidator < ActiveModel::Validator
  def validate(record)
    if record.start_date <= DateTime.now - 1
      record.errors[:start_date] << 'must not be in the past'
    end

    if record.end_date <= record.start_date
      record.errors[:end_date] << 'must be after start date'
    end
  end
end
