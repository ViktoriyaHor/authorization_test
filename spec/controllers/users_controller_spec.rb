# frozen_string_literal: true
#
require 'rails_helper'

RSpec.describe UsersController, type: :controller do

  context '#new' do
      subject! { get :new }
      let(:user) { double(User) }

      before do
        allow(User).to receive(:new).and_return(user)
      end

      it 'assigns @user variable' do
        expect(assigns(:user)).to be_a_new(User)
      end
      it 'returns a successful response to GET' do
        expect(response).to have_http_status(200)
      end
      it 'render template :new' do
        expect(response).to render_template :new
      end
  end

end
