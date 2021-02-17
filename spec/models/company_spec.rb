require 'rails_helper'

describe Company do
  context 'validation' do
    it 'attributes cannot de blanck' do
      company = Company.new

      expect(company.valid?).to eq false
    end

    
  end
end
