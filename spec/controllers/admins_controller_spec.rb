require 'rails_helper'
require 'factory_bot'
require 'faker'
include FactoryBot::Syntax::Methods
RSpec.describe Administrator::AdminsController, type: :controller do
  include Devise::Test::ControllerHelpers
  let(:admin) { create(:admin) }
  let(:admin_attributes) { attributes_for(:admin) }

  describe 'GET #index' do
  
    it 'returns a successful response' do
      sign_in admin
      get :index
      expect(response).to be_successful
    end
  
    it 'returns all admins' do
      get :index
      expect(assigns(:admins)).to eq(admins)
    end
  end

  describe "GET #show" do
    it "renders index template" do
        sign_in admin
        get :show, params: { id: admin.id }
        expect(response).to render_template(:show)
    end

    it "returns http success" do
      sign_in admin
      get :show, params: { id: admin.id }
      expect(response).to have_http_status(:success)
      expect(response).to have_http_status(200)

    end
  end

  describe "GET #new" do
    it "returns http success" do
      sign_in admin
      get :new
      expect(response).to have_http_status(:success)
      expect(response).to have_http_status(200)

    end
  end

  describe "GET #edit" do
    it "returns http success" do
      sign_in admin
      get :edit, params: { id: admin.id }
      expect(response).to have_http_status(:success)
      expect(response).to have_http_status(200)
    end
  end

  describe "DELETE #destroy" do
    it "destroys the admin" do
      sign_in admin
      admin = create(:admin)
      expect {
        delete :destroy, params: { id: admin.id }
      }.to change(Admin, :count).by(-1)
    end

    it "redirects to the admins#index" do
      sign_in admin
      delete :destroy, params: { id: admin.id }
      expect(response).to redirect_to(admins_path)
    end
  end

  describe "POST #create" do
    context "with valid attributes" do
      it "creates a new admin" do
        sign_in admin
        expect {
          post :create, params: { admin: admin_attributes }
        }.to change(Admin, :count).by(1)
      end

      it "redirects to the new admin" do
        sign_in admin
        post :create, params: { admin: admin_attributes }
        expect(response).to redirect_to(admin_path(assigns[:admin]))
      end
    end

    context "with invalid attributes" do
      it "does not create a new admin" do
        sign_in admin
        expect {
          post :create, params: { admin: { first_name: nil } }
        }.to_not change(Admin, :count)
      end

      it "re-renders the new method" do
        sign_in admin
        post :create, params: { admin: { first_name: nil } }
        expect(response).to render_template(:new)
      end
    end
  end
end
