require 'rails_helper'

RSpec.describe Talent, type: :model do
  it { is_expected.to validate_presence_of :username }
  it { is_expected.to validate_presence_of :email }
  

  describe 'associations' do
    it { is_expected.to have_many(:talent_courses) }
    it { is_expected.to have_many(:talent_learning_paths) }
    it { is_expected.to have_many(:courses).through(:talent_courses) }
    it { is_expected.to have_many(:learning_paths).through(:talent_learning_paths) }
    it { should belong_to(:author) }
  end
end
