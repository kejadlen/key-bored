require "strscan"

module KeyBored
  class SExp
    # A quick and dirty s-expression parser meant specifically for parsing KiCad files
    def self.parse(str)
      ss = StringScanner.new(str)
      raise "OMG" if ss.scan(/\s*\(/).nil?

      stack = [self.new]

      until ss.eos?
        case
        when ss.scan(/\(/)
          stack << self.new
        when ss.scan(/\)/)
          last = stack.pop
          return last if stack.empty?
          stack.last << last
        when text = ss.scan(/".*[^\\]"/)
          stack.last << text.gsub(/\A"(.*)"\z/, '\1').gsub('\"', '"')
        when text = ss.scan(/[^)\s]+/)
          stack.last << text
        when ss.scan(/\s+/)
          # Ignore whitespace
        else
          raise "OMG"
        end
      end

      raise "OMG"
    end

    attr_reader :data

    def initialize
      @data = []
    end

    def <<(value)
      data << value
    end

    def args
      data[1..-1]
    end

    def op
      data[0]
    end

    def to_a
      data.map do |value|
        (self.class === value) ? value.to_a : value
      end
    end
  end
end
