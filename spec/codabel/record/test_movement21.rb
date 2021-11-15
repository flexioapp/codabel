require 'spec_helper'

describe Codabel::Record::Movement21 do
  subject {
    Codabel::Record::Movement21.for(data)
  }

  context 'with empty data' do
    let(:data) {
      { entry_date: Date.parse('2021-11-18') }
    }

    it 'generates a default record' do
      got = subject.to_coda
      expected = <<CODA.strip
2100010000                     0000000000000000000000000000000                                                     18112100000 0
CODA
      expect(got).to eql(expected)
    end
  end

  context 'with typical data' do
    let(:data) {
      {
        sequence_number: 17,
        detail_number: 3,
        bank_reference: 'foo bar',
        amount: -123.45,
        value_date: Date.parse('2021-11-17'),
        entry_date: Date.parse('2021-11-18'),
        communication: 'Hello world'
      }
    }

    it 'generates a default record' do
      got = subject.to_coda
      expected = <<CODA.strip
2100170003foo bar              1000000000012345171121000000000Hello world                                          18112100000 0
CODA
      expect(got).to eql(expected)
    end
  end
end
