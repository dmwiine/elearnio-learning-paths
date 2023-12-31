require 'rails_helper'

RSpec.describe TalentLearningPath, type: :model do
  it { is_expected.to validate_presence_of :learning_path }
  it { is_expected.to validate_presence_of :talent }
  

  describe 'associations' do
    it { should belong_to(:learning_path) }
    it { should belong_to(:talent) }
  end
end
