require 'rails_helper'

RSpec.describe User, type: :model do
  subject(:user) { build(:user) }

  describe 'columns' do
    %i[ id email password_digest secret_key created_at updated_at ].each do |field|
      it { is_expected.to have_db_column(field) }
    end
    it { is_expected.to have_db_index(:email) }
  end

  describe 'validations' do
    it { is_expected.to validate_presence_of(:email) }
    it { is_expected.to validate_uniqueness_of(:email) }
    it { is_expected.to validate_length_of(:email).is_at_most(255) }
    it { is_expected.to_not allow_value("blah").for(:email) }
    it { is_expected.to allow_value("user@gmail.com").for(:email) }
    it { is_expected.to validate_confirmation_of(:password) }
    it { is_expected.to validate_length_of(:password).is_at_least(6) }
    it { is_expected.to validate_presence_of(:secret_key) }
  end
end
