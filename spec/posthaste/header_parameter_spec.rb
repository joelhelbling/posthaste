RSpec.describe Posthaste::HeaderParameter do
  Given(:subject) { described_class.new name: 'Paige' }

  context 'is a parameter' do
    Then do
      expect(subject).to respond_to(
        :name, :value, :value=, :required?, :satisfied?
      )
    end
  end

  describe '.type' do
    Then { subject.type == :header_parameter }
  end

  describe '.to_s' do
    context 'integer' do
      When { subject.value = 12 }
      Then { subject.to_s == 'Paige:12' }
    end

    context 'String' do
      When { subject.value = 'seven' }
      Then { subject.to_s == 'Paige:seven' }
    end
  end
end

