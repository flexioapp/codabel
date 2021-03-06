module Codabel
  class Record
    class NewBalance < Record
      FOLLOWING = { when_true: '1', when_false: '0' }.freeze

      column 1..1,     nil,                    Type::N,                     default: 8
      column 2..4,     :sequence_number_paper, Type::N,                     default: 0
      column 5..41,    :account,               Type::AccountAndCurrency,    default: ''
      column 42..42,   :balance,               Type::AmountSign,            default: 0
      column 43..57,   :balance,               Type::Amount,                default: 0
      column 58..63,   :balance_date,          Type::Date,                  default: Date.today
      column 64..127,  nil,                    Type::AN,                    default: ''
      column 128..128, :communication_follows, Type::Flag.new(**FOLLOWING), default: false

      def balance
        data[:balance] || 0
      end

      def validate!(file)
        return unless (old_balance = file.find_record(OldBalance))

        expected = old_balance.balance + file.find_records(Movement21).map(&:amount).sum
        check!(expected == balance, "Invalid new balance: expected #{expected}, got #{balance}")
      end
    end
  end
end
