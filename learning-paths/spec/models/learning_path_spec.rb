require 'rails_helper'

RSpec.describe LearningPath, type: :model do
  it { is_expected.to validate_presence_of :name }
  
  describe 'associations' do
    it { is_expected.to have_many(:courses) }
    it { is_expected.to have_many(:talent_learning_paths) }
    it { is_expected.to have_many(:talents).through(:talent_learning_paths) }
  end
end
