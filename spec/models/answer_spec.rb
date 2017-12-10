require 'rails_helper'

RSpec.describe Answer, type: :model do
  # before {create(:answer)} уточнить
  it { should validate_presence_of :body }
  it { should belong_to :question }
  it { should belong_to :user }
end

