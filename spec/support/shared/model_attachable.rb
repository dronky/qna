shared_examples_for 'attachable' do
  it { should accept_nested_attributes_for :attachments }
  it { should have_many :attachments }
end