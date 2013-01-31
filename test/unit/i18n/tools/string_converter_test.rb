require 'test_helper'
require 'i18n/tools/string_converter'

describe I18n::Tools::StringConverter do

  it 'converts a string delimited by tab to an hash' do
    str = "a\tb\n"
    h = {"a" => "b"}
    converter = I18n::Tools::StringConverter.new(str)
    converter.to_h.must_equal h
  end

end
