require File.join(File.dirname(__FILE__), 'helper')

class RPM_Header_Tests < Test::Unit::TestCase

  def test_create

    pkg = RPM::Package.create('foo', '1.0')
    assert_equal 'foo', pkg.name
    assert_equal '(none)', pkg.signature
  end

  def test_open
    
    pkg = RPM::Package.open(fixture('simple-1.0-0.i586.rpm'))
    
    assert_equal "simple-1.0-0-i586", pkg.to_s

    assert_equal '6895248ed5a081f73d035174329169c7', pkg.signature

    assert_kind_of RPM::Package, pkg
    assert_equal 'simple', pkg[:name]
    assert_equal 'i586', pkg[:arch]
    assert_equal '1.0-0', pkg.version

    backup_lang = ENV['LANG']

    ENV['LANG'] = 'C'
    assert_equal 'Simple dummy package', pkg[:summary]
    assert_equal 'Dummy package', pkg[:description]
    
    ENV['LANG'] = 'es'
    assert_equal 'Paquete simple de muestra', pkg[:summary]
    assert_equal 'Paquete de muestra', pkg[:description]

    ENV['LANG'] = backup_lang
    
    # Arrays
    assert_equal ["root", "root"], pkg[:fileusername]
    assert_equal [6, 5], pkg[:filesizes]

    assert pkg.provides.map(&:name).include?("simple(x86-32)")
    assert pkg.provides.map(&:name).include?("simple")

    assert pkg.requires.map(&:name).include?("/bin/sh")

    assert pkg.files.map(&:path).include?("/usr/share/simple/README")
    assert pkg.files.map(&:path).include?("/usr/share/simple/README.es")

    assert_equal ["- Fix something", "- Fix something else"], pkg.changelog.map(&:text)
  end

end
