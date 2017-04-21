require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'User' do
    subject(:user) do
      FactoryGirl.build(:user,
        username: 'user',
        password: 'password')
    end

    it 'creates a password_digest from password' do
      expect(user.password_digest).to_not be_nil
    end

    it { should validate_presence_of(:username)}
    it { should validate_presence_of(:password_digest)}
    it { should validate_uniqueness_of(:username)}

    describe '::find_by_credentials' do
      before { user.save! }

      it 'should find user by username' do
        expect(User.find_by_credentials('user')).to eq(user)
      end
    end

    describe '#is_password?' do
      it 'verifies a password is correct' do
        expect(user.is_password?('password')).to be(true)
      end
      it 'verifies a password is not correct' do
        expect(user.is_password?('bad')).to be(false)
      end
    end

    describe 'session token' do
      it 'creates a session token' do
        user.valid?
        expect(user.session_token).to_not be nil
      end

      describe 'reset session token!' do
        it 'sets a new session token on the user' do
          old = user.session_token
          user.reset_session_token!
          expect(user.session_token).to_not eq(old)
        end

        it 'returns the new session token' do
          expect(user.reset_session_token!).to eq(user.session_token)
        end
      end
    end
  end
end
