require 'rails_helper'

RSpec.describe Answer, type: :model do
  it_behaves_like 'attachable'
  it_behaves_like 'commentable'
  it_behaves_like 'votable'

  it { should validate_presence_of :body }
  it { should belong_to :question }
  it { should belong_to :user }
end

