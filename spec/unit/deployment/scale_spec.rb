require 'spec_helper'

describe Scaler::Deployment::Scale do
  include_context 'default values'

  let(:deployment) {
    Scaler::Deployment.new(YAML.load(base_manifest))
  }

  subject(:scale) {
    deployment.scale
  }

  describe '#job' do
    it 'returns a specified job' do
      expect(scale.job('job0a')).not_to eq(nil)
      expect(scale.job('job0b')).not_to eq(nil)
    end
  end

  describe '#network' do
    it 'returns a specified network' do
      expect(scale.network('net00')).not_to eq(nil)
    end
  end
end

describe Scaler::Deployment::Scale::Job do
  include_context 'default values'

  let(:deployment) {
    Scaler::Deployment.new(YAML.load(base_manifest))
  }

  subject(:job) {
    deployment.scale.job('job0a')
  }

  describe '#name' do
    it 'returns the given job name' do
      expect(job.name).to eq('job0a')
    end
  end

  describe '#cooldown_time' do
    it 'returns the given cooldown time' do
      expect(job.cooldown_time).to eq(39)
    end
  end

  describe '#out_limit' do
    it 'returns the given out limit' do
      expect(job.out_limit).to eq(9)
    end
  end

  describe '#out_unit' do
    it 'returns the given out unit' do
      expect(job.out_unit).to eq(3)
    end

    context 'out unit is not defined' do
      subject(:job) {
        deployment.scale.job('job0b')
      }

      it 'returns nil' do
        expect(job.out_unit).to eq(nil)
      end
    end
  end

  describe '#out_conditions' do
    it 'returns the given condition list' do
      expect(job.out_conditions.size).to eq(1)
      expect(job.out_conditions[0]).to eq(
        { 'class' => 'dummy_out0a',
          'additional' => 'value_out0a' }
      )
    end
  end

  describe '#in_limit' do
    it 'returns the given out limit' do
      expect(job.in_limit).to eq(3)
    end
  end

  describe '#in_unit' do
    it 'returns the given in unit' do
      expect(job.in_unit).to eq(2)
    end

    context 'in unit is not defined' do
      subject(:job) {
        deployment.scale.job('job0b')
      }

      it 'returns nil' do
        expect(job.in_unit).to eq(nil)
      end
    end
  end

  describe '#in_conditions' do
    it 'returns the given condition list' do
      expect(job.in_conditions.size).to eq(1)
      expect(job.in_conditions[0]).to eq(
        { 'class' => 'dummy_in0a',
          'additional' => 'value_in0a' }
      )
    end
  end
end

describe Scaler::Deployment::Scale::Network do
  include_context 'default values'

  let(:deployment) {
    Scaler::Deployment.new(YAML.load(base_manifest))
  }

  subject(:network) {
    deployment.scale.network('net00')
  }

  describe '#name' do
    it 'returns the given job name' do
      expect(network.name).to eq('net00')
    end
  end

  describe '#static_ips' do
    it 'returns the given static ip address list' do
      expect(network.static_ips).to eq(%w{10.39.3.100 10.39.3.101})
    end
  end

  describe '#pop_static_ip' do
    it 'returns a static IP address and remove it from the list' do
      expect(network.pop_static_ip).to eq('10.39.3.101')
    end

    it 'raises an error when no static IP address avaiable' do
      network.pop_static_ip
      network.pop_static_ip
      expect {
        network.pop_static_ip
      }.to raise_error
    end
  end
end
