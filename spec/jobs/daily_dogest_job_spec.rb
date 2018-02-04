require 'rails_helper'

RSpec.describe DailyDogestJob, type: :job do
  it 'sends daily digest' do
    expect(User).to receive(:send_daily_digest)
    DailyDogestJob.perform_now
  end
end
