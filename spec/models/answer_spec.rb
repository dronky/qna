require 'rails_helper'

RSpec.describe Answer, type: :model do
  # before {create(:answer)}
  it { should validate_presence_of :body }
  it { should belong_to :question }
  it { should belong_to :user }
  it { should accept_nested_attributes_for :attachments }
  it { should have_many :attachments }
end

