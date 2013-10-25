require_relative 'helper'
require 'timecop'

class OutUniqueCounterTest < Test::Unit::TestCase
  def setup
    Fluent::Test.setup
  end

  def teardown
    Timecop.return
  end

  CONFIG_INTERVAL_10 = %[
    tag api.production.login
    unique_key user_id
    count_interval 10
  ]

  CONFIG_INTERVAL_30 = %[
    tag api.production.login
    unique_key user_id
    count_interval 30
  ]

  CONFIG_UNIT_MINUTES = %[
    tag api.production.login
    unique_key user_id
    unit minutes
  ]

  CONFIG_UNIT_HOURS = %[
    tag api.production.login
    unique_key user_id
    unit hours
  ]

  CONFIG_UNIT_DAYS = %[
    tag api.production.login
    unique_key user_id
    unit days
  ]

  def create_driver(conf = CONFIG, tag = 'test')
    Fluent::Test::OutputTestDriver.new(Fluent::UniqueCounterOutput, tag).configure(conf)
  end

  def test_unique_count_interval_10
    d1 = create_driver(CONFIG_INTERVAL_10, 'uniq.countup')

    d1.run do
      Timecop.freeze(Time.now + 10)
      d1.emit({"user_id" => "1000"})
      d1.emit({"user_id" => "1000"})
      d1.emit({"user_id" => "1000"})
      d1.emit({"user_id" => "1001"})
      d1.emit({"user_id" => "1002"})
      d1.emit({"user_id" => "1002"})
      sleep 1
      Timecop.return
    end

    emits = d1.emits

    p emits[0]
    assert_equal "api.production.login", emits[0][0]
    assert_equal 3, emits[0][2]["unique_count"]
  end

  def test_unique_count_interval_30
    d1 = create_driver(CONFIG_INTERVAL_30, 'uniq.countup')

    d1.run do
      Timecop.freeze(Time.now + 30)
      d1.emit({"user_id" => "1000"})
      d1.emit({"user_id" => "1000"})
      d1.emit({"user_id" => "1000"})
      d1.emit({"user_id" => "1001"})
      d1.emit({"user_id" => "1002"})
      d1.emit({"user_id" => "1002"})
      sleep 1
      Timecop.return
    end

    emits = d1.emits

    p emits[0]
    assert_equal "api.production.login", emits[0][0]
    assert_equal 3, emits[0][2]["unique_count"]
  end

  def test_unique_count_unit_minutes
    d1 = create_driver(CONFIG_UNIT_MINUTES, 'uniq.countup')

    d1.run do
      Timecop.freeze(Time.now + 60)
      d1.emit({"user_id" => "1000"})
      d1.emit({"user_id" => "1000"})
      d1.emit({"user_id" => "1000"})
      d1.emit({"user_id" => "1001"})
      d1.emit({"user_id" => "1002"})
      d1.emit({"user_id" => "1002"})
      sleep 1
      Timecop.return
    end

    emits = d1.emits

    p emits[0]
    assert_equal "api.production.login", emits[0][0]
    assert_equal 3, emits[0][2]["unique_count"]
  end

  def test_unique_count_unit_hours
    d1 = create_driver(CONFIG_UNIT_HOURS, 'uniq.countup')

    d1.run do
      Timecop.freeze(Time.now + 3600)
      d1.emit({"user_id" => "1000"})
      d1.emit({"user_id" => "1000"})
      d1.emit({"user_id" => "1000"})
      d1.emit({"user_id" => "1001"})
      d1.emit({"user_id" => "1002"})
      d1.emit({"user_id" => "1002"})
      sleep 1
      Timecop.return
    end

    emits = d1.emits

    p emits[0]
    assert_equal "api.production.login", emits[0][0]
    assert_equal 3, emits[0][2]["unique_count"]
  end

  def test_unique_count_unit_days
    d1 = create_driver(CONFIG_UNIT_DAYS, 'uniq.countup')

    d1.run do
      Timecop.freeze(Time.now + 86400)
      d1.emit({"user_id" => "1000"})
      d1.emit({"user_id" => "1000"})
      d1.emit({"user_id" => "1000"})
      d1.emit({"user_id" => "1001"})
      d1.emit({"user_id" => "1002"})
      d1.emit({"user_id" => "1002"})
      sleep 1
      Timecop.return
    end

    emits = d1.emits

    p emits[0]
    assert_equal "api.production.login", emits[0][0]
    assert_equal 3, emits[0][2]["unique_count"]
  end

end
