# coding: utf-8
#
class Fluent::UniqCounterOutput < Fluent::Output
  Fluent::Plugin.register_output('unique_counter', self)

  config_param :count_interval, :time, :default => 60
  config_param :unit, :string, :default => nil
  config_param :unique_key, :string

  config_param :tag, :string, :default => 'unique_count'

  attr_accessor :tick
  attr_accessor :counts
  attr_accessor :last_checked

  UNITS = {
    minutes: 60,
    hours: 3600,
    days: 86400
  }

  def configure(conf)
    super

    if @unit and UNITS[@unit.to_sym].nil?
      raise Fluent::ConfigError, "'unit' must be one of minutes/hours/days"
    end
    @count_interval = UNITS[@unit.to_sym] if @unit

    @counts = []
    @mutex = Mutex.new
  end

  def start
    super
    start_watch
  end

  def shutdown
    super
    @watcher.terminate
    @watcher.join
  end

  def flush_emit
    flushed,@counts = @counts,[]
    message = {'unique_count' => flushed.uniq.count }
    Fluent::Engine.emit(@tag, Fluent::Engine.now, message)
  end

  def start_watch
    # for internal, or tests only
    @watcher = Thread.new(&method(:watch))
  end

  def watch
    # instance variable, and public accessable, for test
    @last_checked = Fluent::Engine.now
    while true
      sleep 0.5
      if (Fluent::Engine.now - @last_checked) >= @count_interval
        now = Fluent::Engine.now
        flush_emit
        @last_checked = now
      end
    end
  end

  def emit(tag, es, chain)
    c = []

    es.each do |time,record|
      value = record[@unique_key]
      next if value.nil?

      c << value.to_s.force_encoding('ASCII-8BIT')
    end
    @mutex.synchronize {
      @counts += c
    }

    chain.next
  end
end
