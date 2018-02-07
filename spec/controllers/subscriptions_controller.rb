require 'rails_helper'

RSpec.describe SubscriptionsController, type: :controller do
  describe 'POST #create' do
    context 'authorized user' do
      sign_in_user
      let(:question) {create(:question, user: @user)}
      it 'creates a valid subscription' do
        expect {post :create, params: {format: :js, question: question}}
            .to change(question.subscriptions, :count).by(1)
      end
    end
    context 'unauthorized user' do
      let(:question) {create(:question)}
      it 'creates a valid subscription' do
        expect {post :create, params: {format: :js, question: question}}
            .not_to change(question.subscriptions, :count)
      end
    end
  end

  describe 'DELETE #destroy' do
    context 'authorized user' do
      sign_in_user
      let(:question) {create(:question, user: @user)}
      it 'deletes a subscription' do
        expect {delete :destroy, params: {format: :js, id: @user.question_subscription(question)}}
            .to change(question.subscriptions, :count).by(-1)
      end
    end
    context 'unauthorized user' do
      let(:question) {create(:question)}
      it 'trying to delete a subscription' do
        expect {delete :destroy, params: {format: :js, id: question}}
            .not_to change(question.subscriptions, :count)
      end
    end
  end
end
