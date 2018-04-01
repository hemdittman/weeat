require 'rails_helper'

RSpec.describe Cuisine, type: :model do
  describe '#validations' do
    it { is_expected.to validate_presence_of :name }
  end
end
