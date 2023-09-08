require 'rails_helper'

RSpec.describe TalentCourse, type: :model do
  it { is_expected.to validate_presence_of :course }
  it { is_expected.to validate_presence_of :talent }
  

  describe 'associations' do
    it { should belong_to(:course) }
    it { should belong_to(:talent) }
  end
end
