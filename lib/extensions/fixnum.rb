# Some time-related helpers.
class Fixnum
  # Go back in time from right now.
  #
  #   5.days.ago => 2014-06-12 13:21:38 +0200
  #
  # @return [Time]
  def ago
    before(Time.now)
  end

  # Go forward in time from right now.
  #
  #   5.days.from_now => 2014-06-22 13:21:42 +0200
  #
  # @return [Time]
  def from_now
    after(Time.now)
  end

  # Go back in time from some other time.
  #
  #   some_time = Time.new(2014, 6, 17)
  #   5.days.before(some_time) => 2014-06-12 00:00:00 +0200
  #
  # @param time [Time]
  # @return     [Time]
  def before(time)
    time - self
  end

  # Go forward in time from some other time.
  #
  #   some_time = Time.new(2014, 6, 17)
  #   5.days.after(some_time) => 2014-06-22 00:00:00 +0200
  #
  # @param time [Time]
  # @return     [Time]
  def after(time)
    time + self
  end

  # Seconds as, well, seconds.
  #
  #   5.seconds => 5
  #
  # @return [Fixnum]
  def seconds
    self
  end
  alias_method :second, :seconds

  # Minutes as seconds.
  #
  #   5.minutes => 5 * 60 => 300
  #
  # @return [Fixnum]
  def minutes
    self * 60
  end
  alias_method :minute, :minutes

  # Hours as seconds.
  #
  #   5.hours => 5 * 60 * 60 => 5 * 3600 => 18000
  #
  # @return [Fixnum]
  def hours
    self * 3_600
  end
  alias_method :hour, :hours

  # Days as seconds.
  #
  #   5.days => 5 * 60 * 60 * 24 => 5 * 86400 => 432000
  #
  # @return [Fixnum]
  def days
    self * 86_400
  end
  alias_method :day, :days
end
