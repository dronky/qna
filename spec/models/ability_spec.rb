require 'rails_helper'

describe Ability do
  subject(:ability) {Ability.new(user)}

  describe 'for guest' do
    let(:user) {nil}

    it {should be_able_to :read, Question}
    it {should be_able_to :read, Answer}
    it {should be_able_to :read, Comment}

    it {should_not be_able_to :manage, :all}
  end

  describe 'for admin' do
    let(:user) {create :user, admin: true}

    it {should be_able_to :manage, :all}
  end

  describe 'for user' do
    let(:user) {create :user}
    let(:other) {create :user}

    it {should_not be_able_to :manage, :all}
    it {should be_able_to :read, :all}

    context 'question' do
      let(:question) {create(:question, user: user)}
      let(:other_question) {create(:question, user: other)}
      it {should be_able_to :create, Question}
      it {should be_able_to :update, question, user: user}
      it {should_not be_able_to :update, other_question, user: user}
      it {should be_able_to :destroy, question, user: user}
      it {should_not be_able_to :destroy, other_question, user: user}
      it {should be_able_to :vote, other_question, user: user}
      it {should_not be_able_to :vote, question, user: user}
    end

    context 'answer' do
      let(:question) {create(:question, user: user)}
      let(:answer) {create(:answer, question: question, user: user)}
      let(:other_answer) {create(:answer, user: other)}
      it {should be_able_to :create, Answer}
      it {should be_able_to :update, answer, user: user}
      it {should_not be_able_to :update, other_answer, user: user}
      it {should be_able_to :destroy, answer, user: user}
      it {should_not be_able_to :destroy, other_answer, user: user}
      it {should be_able_to :vote, other_answer, user: user}
      it {should_not be_able_to :vote, answer, user: user}
      it {should be_able_to :mark_as_best, answer, user: user}
      it {should_not be_able_to :mark_as_best, other_answer, user: user}
    end

    context 'comment' do
      it {should be_able_to :create, Comment}
    end
  end
end