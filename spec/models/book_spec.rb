# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Book do
  describe 'validations' do
    subject(:book) { build(:book) }

    it 'it is valid with valid attributes' do
      expect(book).to be_valid
    end

    describe 'name' do
      it { is_expected.to validate_presence_of(:name) }
    end

    describe 'author' do
      it { is_expected.to validate_presence_of(:author) }
    end

    describe 'page_quantity' do
      it { is_expected.to validate_presence_of(:page_quantity) }

      it do
        is_expected.to validate_numericality_of(:page_quantity)
          .only_integer
          .is_greater_than(0)
      end
    end
  end
end
