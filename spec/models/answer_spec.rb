require 'rails_helper'

RSpec.describe Answer, type: :model do
  before { FactoryGirl.build(:answer) }
  it { should validate_presence_of :body }
  it { should have_one :question }
end

