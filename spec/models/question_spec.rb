require 'rails_helper'

RSpec.describe Question, type: :model do
  it_behaves_like 'attachable'
  it_behaves_like 'commentable'
  it_behaves_like 'votable'

  before { FactoryGirl.build(:question) }
  it { should validate_presence_of :title }
  it { should validate_presence_of :body }
  it { should have_many(:answers)}
  it { should belong_to(:user)}

end
