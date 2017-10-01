require 'rails_helper'

RSpec.describe Question, type: :model do
  before { FactoryGirl.build(:question) }
  it { should validate_presence_of :title }
  it { should validate_presence_of :body }
  it { should have_many(:answers)}
end
