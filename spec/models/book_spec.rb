# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Book do
  describe 'model validations' do
    it { is_expected.to validate_presence_of(:name) }
    it { is_expected.to validate_presence_of(:author) }
    it { is_expected.to validate_presence_of(:page_quantity) }

    it { is_expected.to validate_numericality_of(:page_quantity).only_integer.is_greater_than(0) }
  end
end
