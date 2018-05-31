RSpec.describe Posthaste::Parameter do
  context 'must have a name' do
    Then { expect { described_class.new }.to raise_error(ArgumentError) }
    Then { expect { described_class.new name: 'bob' }.to_not raise_error }
  end

  describe '.required?' do
    context 'defaults to false' do
      Given(:subject) { described_class.new name: 'Jean' }

      Then { expect(subject).to_not be_required }
    end

    context 'when set to true' do
      Given(:subject) { described_class.new name: 'Sam', required: true }

      Then { expect(subject).to be_required }
    end
  end

  describe '.satisfied?' do
    context 'when not required' do
      Given(:subject) { described_class.new name: 'Gwen' }

      context 'with value' do
        When { subject.value = 4 }

        Then { expect(subject).to be_satisfied }
      end

      context 'without value' do
        Then { expect(subject).to be_satisfied }
      end
    end

    context 'when required' do
      Given(:subject) { described_class.new name: 'Garth', required: true }

      context 'with value' do
        When { subject.value = :hello }

        Then { expect(subject).to be_satisfied }
      end

      context 'without value' do
        Then { expect(subject).not_to be_satisfied }
      end
    end
  end

  describe '.type' do
    Given(:subject) { described_class.new name: 'Ben' }

    Then { subject.type == :generic_parameter }
  end

  describe '.to_s' do
    Given(:subject) { described_class.new name: 'Hanna', value: 'Montana', required: true }

    Then { subject.to_s == subject.inspect }
  end
end
