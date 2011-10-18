require File.join(File.dirname(__FILE__), 'helper')

class RPM_RPM_Tests < Test::Unit::TestCase

  def test_enum
    assert RPM::TAG[:not_found]
  end

  def test_compat
    #puts RPM::LOG_ALERT
    #assert_raise(NameError) { RPM::LOG_ALERT }

    #require 'rpm/compat'
    assert_nothing_raised { RPM::LOG_ALERT }
    assert_equal RPM::LOG_ALERT, RPM::LOG[:alert]
  end

  def test_iterator
    RPM.transaction do |t|
      assert_kind_of RPM::Transaction, t
      #t.each do |pkg|
      #  puts pkg[:name]
      #end
    end
  end

  def test_macro_read
    assert_equal '/usr', RPM['_usr']
  end

  #def test_macro_write
  #  RPM['hoge'] = 'hoge'
  #  assert_equal( RPM['hoge'], 'hoge' )
  #end # def test_macro_write


end # class RPM_RPM_Tests < Test::Unit::TestCase
