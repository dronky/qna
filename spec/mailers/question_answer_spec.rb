require "rails_helper"

RSpec.describe QuestionAnswerMailer, type: :mailer do
  describe "question_subscription" do
    let(:subscription) {create(:subscription)}
    let(:mail) { QuestionAnswerMailer.question_subscription(subscription) }

    it "renders the headers" do
      expect(mail.subject).to eq("Question subscription")
      expect(mail.to).to eq(["#{subscription.user.email}"])
      expect(mail.from).to eq(["from@example.com"])
    end

    it "renders the body" do
      expect(mail.body.encoded).to match("Your question has been answered!")
    end
  end
end
