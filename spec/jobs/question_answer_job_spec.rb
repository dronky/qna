require 'rails_helper'

RSpec.describe QuestionAnswerJob, type: :job do
  it 'sends notification if question has been answered' do
    expect(User).to receive(:send_daily_digest)
    DailyDigestJob.perform_now
  end
end
