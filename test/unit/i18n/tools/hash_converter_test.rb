require 'test_helper'
require 'i18n/tools/hash_converter'

describe I18n::Tools::HashConverter do

  it 'converts a simple key-value Hash to a string-"value" pair' do
    converter =  I18n::Tools::HashConverter.new({:a => "b"})
    converter.to_s.must_equal "a\tb\n"
  end

  it 'converts a swallow multi key-value Hash to some string-"value" pairs' do
    converter =  I18n::Tools::HashConverter.new({:a => "b", :c => "d"})
    converter.to_s.must_equal "a\tb\nc\td\n"
  end

  it 'converts a 2 levels deep Hash to some string-"value" pairs' do
    converter =  I18n::Tools::HashConverter.new({:a => {:b => "c"}})
    converter.to_s.must_equal "a.b\tc\n"
  end

  it 'converts a 2 levels deep multi-key Hash to some string-"value" pairs' do
    converter =  I18n::Tools::HashConverter.new({:a => {:b => "c"}, :d => {:e => "f"}})
    converter.to_s.must_equal "a.b\tc\nd.e\tf\n"
  end

  it 'converts a arbitrary deep Hash to string-"value" pairs' do
    h = {:a => "b", :c => {:d => "e"}, :f => {:g => {:h => "i"}}}
    converter =  I18n::Tools::HashConverter.new(h)
    converter.to_s.must_equal "a\tb\nc.d\te\nf.g.h\ti\n"
  end

  it 'converts a simple key-value Hash to a string-"value" pair when value is an Array' do
    converter =  I18n::Tools::HashConverter.new({:a => ["b", "c"]})
    converter.to_s.must_equal "a\t[\"b\", \"c\"]\n"
  end

end