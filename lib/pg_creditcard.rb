require 'creditcard'

class PgCreditcard
  
  def initialize(options)
    raise ArgumentError if options.nil?
    @name   = options[:name]
    @number = options[:number]
    @month  = options[:month]
    @year   = set_year(options[:year])
    @cvv    = options[:cvv]
  end
  
  def type
    return nil if @number.nil?
    @type ||= @number.to_s.creditcard_type
  end
  
  def valid?
    @number.to_s.creditcard?
  end
  
  def expired?
    today = Time.now
    expiry = Time.new(@year, @month, days_in_a_month(@year, @month))
    today > expiry
  end
  
  def cardholder
    @name
  end
  
  def cardnumber
    @number
  end
  
  def cardexpmonth
    @month
  end
  
  def cardexpyear
    @year[2..3]
  end
  
  private
  
  def set_year(x)
    if x.length == 2
      year = "20".concat(x)
    else
      year = x
    end
    year
  end
  
  def days_in_a_month(year, month)
    if month == 12
      year += 1
      next_month = 1
    else
      next_month = month.to_i + 1
    end
    next_month_first_day = Time.new(year, next_month)
    last_day_current_month = (next_month_first_day-1).day
    days = last_day_current_month
    days
  end
  
end