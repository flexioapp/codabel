module Codabel
  class Type
    class Amount < Type
      def to_coda(value, length)
        (value * 100).to_i.to_s.rjust(length, '0')
      end
    end
  end
end