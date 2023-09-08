require 'rails_helper'

RSpec.describe Author, type: :model do
  it { is_expected.to validate_presence_of :firstname }
  it { is_expected.to validate_presence_of :lastname }
  
  

  describe 'associations' do
    it { is_expected.to have_many(:courses).through(:talents) }
  end
end
