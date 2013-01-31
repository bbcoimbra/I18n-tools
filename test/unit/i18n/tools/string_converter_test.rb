require 'test_helper'
require 'i18n/tools/string_converter'

describe I18n::Tools::StringConverter do

  it 'converts a string delimited by tab to an hash' do
    str = "a\tb\n"
    h = {"a" => "b"}
    converter = I18n::Tools::StringConverter.new(str)
    converter.to_h.must_equal h
  end

  it 'converts a dotted string key delimited by tab to an hash' do
    str = "a.b\tc\n"
    h = {"a" => {"b" => "c"}}
    converter = I18n::Tools::StringConverter.new(str)
    converter.to_h.must_equal h
  end

  it 'converts a dotted string key with an array as value to an hash' do
    str = "a.b\t[\"c\", \"d\"]\n"
    h = {"a" => {"b" => ["c", "d"]}}
    converter = I18n::Tools::StringConverter.new(str)
    converter.to_h.must_equal h
  end

  it 'converts a dotted string key with an array (not so well formatted) as value to an hash' do
    str = "a.b\t[\"c\",\"d\"]\n"
    h = {"a" => {"b" => ["c", "d"]}}
    converter = I18n::Tools::StringConverter.new(str)
    converter.to_h.must_equal h
  end

end
