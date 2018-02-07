require 'rails_helper'

RSpec.describe QuestionAnswerJob, type: :job do
 let(:question) {create(:question)}
  it 'sends notification if question has been answered' do
    message_delivery = instance_double(ActionMailer::MessageDelivery)
    expect(QuestionAnswerMailer).to receive(:question_subscription).with(Subscription).and_return(message_delivery)
    allow(message_delivery).to receive(:deliver_later)

    QuestionAnswerJob.perform_now(question)
  end
end
