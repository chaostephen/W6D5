class Cat < ApplicationRecord
    CAT_COLORS = ["Black", "White", "Gray", "Orange", "Calico"].freeze
    validates :name, :description, presence: true
    validates :color, presence: true, inclusion: { in: CAT_COLORS, message: "is not a valid color" }
    validates :sex, presence: true, inclusion: { in: ["M", "F"], message: "must be 'M' or 'F'" }

    def birth_date_cannot_be_future
        if birth_date.present? && birth_date > Date.today
            errors.add(:birth_date, "can't be in the future")
        end
    end

    validate :birth_date_cannot_be_future

  def age

    # Calculate the age by subtracting the birth_date from today's date
    today = Date.today
    debugger
    age_in_years = time_ago_in_words(self.birth_date)

    # You can also optionally include months and days for a more detailed age calculation
    age_in_months = today.month - birth_date.month
    age_in_days = today.day - birth_date.day

    # Return a formatted age string (years, months, and days)
    if age_in_years > 0
      "#{age_in_years} years, #{age_in_months} months, #{age_in_days} days"
    elsif age_in_months > 0
      "#{age_in_months} months, #{age_in_days} days"
    else
      "#{age_in_days} days"
    end
  end

  validate :age


end

def time_ago_in_words(date)
  day = date.day
  month = date.month
  year = date.year

  total_days = Date.today - day.days - month.months - year.years
  remainder_days = total_days % 365
  return (total_days - remainder_days) / 365
end
