module I18n

  module Tools

    class HashConverter

      def initialize(hash)
        @hash = hash
      end

      def to_s
        str = ""
        hash_to_str(@hash)
      end

      private

        def hash_to_str(hash, ret_str="")
          str = ret_str
          hash.keys.each do |key|
            value = hash.fetch(key)
            if value.is_a? Hash
              str << "#{key}."
              hash_to_str(value, str)
            else
              str << "#{key}\t#{value}\n"
            end
          end
          str
        end

    end

  end

end
