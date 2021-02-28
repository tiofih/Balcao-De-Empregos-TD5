class CompaniesController < ApplicationController
    def show
        @company = Company.find(params[:id])
    end

    before_action :authenticate_user!
    def new
        @company = Company.new
    end

    def create
        company_params = params.require(:company)
                                .permit(:company_name, :street_name,
                                        :street_number, :district,
                                        :city, :cnpj, :company_site,
                                        :company_instagram, :company_twitter,
                                        :company_description, :logo, :user_id)
        @company = Company.new(company_params)
        @company.user_id = current_user.collaborator.id

        if @company.save
            Collaborator.create!(company_id: @company.id, user_id: @company.user_id)
            redirect_to company_path(@company)
        else
            flash[:notice] = t('.error')
            render 'new'
        end
    end
end