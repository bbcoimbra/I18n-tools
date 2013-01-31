module I18n

  module Tools

    class StringConverter

      def initialize(str)
        @string = str
      end

      def to_h
        h = Hash.new{|hash, key| hash[key] = {}}
        lines = @string.split("\n")
        lines.each do |line|
          str_keys, value = line.split("\t")
          keys = str_keys.split(".")
          store(h, keys, value)
        end
        h
      end

      private

      def store(hash, keys, value)
        if keys.size == 1
          hash[keys.first] = format(value)
        else
          ks = keys.dup
          key = ks.shift
          h = hash[key]
          if h.nil?
            h = {}
            hash[key] = h
          end
          store(h, ks, value)
        end
      end

      def format(value)
        if value =~ /^\[/
          parse_array(value)
        else
          value
        end
      end

      def parse_array(value)
        value.sub!('["','').sub!('"]','')
        value.gsub!("\", \"", "\",\"")
        value.split("\",\"")
      end

    end

  end

end
