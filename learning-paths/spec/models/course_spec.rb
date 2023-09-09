require 'rails_helper'

RSpec.describe Course, type: :model do
  it { is_expected.to validate_presence_of :name }
  it { is_expected.to validate_presence_of :order }
  

  describe 'associations' do
    it { is_expected.to have_many(:talent_courses) }
    it { is_expected.to have_many(:talents).through(:talent_courses) }
    it { should belong_to(:author) }
    it { should belong_to(:learning_path) }
  end
end
