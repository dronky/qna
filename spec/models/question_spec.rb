require 'rails_helper'

RSpec.describe Question, type: :model do
  before { FactoryGirl.build(:question) }
  it { should validate_presence_of :title }
  it { should validate_presence_of :body }
  it { should have_many(:answers)}
  it { should belong_to(:user)}
  it { should accept_nested_attributes_for :attachments }
  it { should have_many :attachments }
end
