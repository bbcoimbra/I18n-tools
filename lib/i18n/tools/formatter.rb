require 'rubygems'
require 'yaml'
module I18n
  module Tools
    class Formatter
      def initialize(file)
        @yml_data = YAML.load_file(file)
        @sep="#.#"
        @formatted_keys = []
        @h2a_deep = lambda { |el| el[1].is_a?(Hash) ? [el[0], el[1].map(&@h2a_deep)] : el }
        format_keys
      end

      def inspect
        instance_variables.map do |var|
          "#{var}=" + instance_variable_get(var).to_s
        end
      end

      def dump_keys
        $stdout.print @formatted_keys.join("\n")+"\n"
      end

      def load_keys(file)
        @formatted_keys = File.readlines(file)
        @yml_hash = {}
        @formatted_keys.each do |e|
          keys, value = e.split "\t"
          insert_value_to_result_hash(@yml_hash, keys.split('.'), value)
        end
      end

      def insert_value_to_result_hash(hash, keys, value)
        raise ArgumentError if value.nil? or value.empty?
        if hash.nil? or keys.nil? 
          return
        end
        ks = keys.dup
        key = ks.shift
        if hash.has_key? key
          if hash[key].nil?
            if keys.first.nil?
              hash[key] = value
            else
              hash_new = Hash.new{|hash, key| hash[key]=nil}
              hash[key] = hash_new
              insert_value_to_result_hash(hash_new, ks, value)
            end
          else
            insert_value_to_result_hash(hash[key], ks, value)
          end
        else
          hash_new = Hash.new{|hash, key| hash[key]=nil}
          hash[key] = hash_new
          insert_value_to_result_hash(hash_new, ks, value)
        end
      end

      def format_keys
        format_nodes(@yml_data.map(&@h2a_deep))
      end

      ### XXX a única relação com a classe é o armazenamento
      ### em @result
      def format_nodes(root, result="", ary_result=[])
        return "" if root.nil? or root.empty?
        head, *tail = root
        if head.is_a? String
          if tail.empty?
            result = result[0..-(@sep.size+1)]
            result += ("\t" + head)
            @formatted_keys << result.gsub(@sep, ".") if result.include?(@sep)
          else
            result += "#{head}#{@sep}"
            format_nodes(tail, result)
          end
        else
          root.each do |elem|
            format_nodes(elem, result)
          end
        end
      end
    end
  end
end
