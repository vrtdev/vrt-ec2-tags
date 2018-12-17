# frozen_string_literal: true

RSpec.describe Vrt::Ec2::Tags do
  it 'has a version number' do
    expect(Vrt::Ec2::Tags::VERSION).not_to be nil
  end

  # it 'does something useful' do
  #   expect(false).to eq(true)
  # end

  it 'fails with timeout when not on EC2' do
    expect { Vrt::Ec2::Tags.read_instance_id }.to raise_error(Net::OpenTimeout)
  end

  it 'meta_data_uri returns a URI::HTTP object' do
    expect(Vrt::Ec2::Tags.meta_data_uri).to be_a(URI::HTTP)
  end

  it 'tag_uri returns a URI::HTTP object' do
    expect(Vrt::Ec2::Tags.tag_uri).to be_a(URI::HTTP)
  end
end
