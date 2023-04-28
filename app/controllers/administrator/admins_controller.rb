# frozen_string_literal: true

module Administrator
  class AdminsController < Administrator::BaseController
    before_action :get_admin, only: [:show, :edit, :update, :destroy]

    def index
      @admins = Admin.all
      authorize_admin
    end

    def show
      authorize_admin
    end

    def new
      @admin = Admin.new
      authorize_admin
    end

    def create
      @admin = Admin.new(admin_params)
      authorize_admin
      if @admin.save
        flash[:success] = 'Successfully created admin account'
        redirect_to admin_path(@admin)
      else
        render 'new'
      end
    end    

    def edit
      authorize_admin
    end

    def update
      authorize_admin
      if @admin.update(admin_params)
        flash[:success] = 'Successfully updated admin account'
        redirect_to admin_path(@admin)
      else
        render 'edit'
      end
    end

    def destroy
      authorize_admin
      @admin.destroy
      redirect_to admins_path
    end

    private

    def admin_params
      params.require(:admin).permit(:first_name, :last_name, :email, :password, :phone)
    end

    def get_admin
      @admin = Admin.find(params[:id])
    end

    def authorize_admin
      authorize Admin
    end
  end
end