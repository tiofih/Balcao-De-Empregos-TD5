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
        @company.user_id = current_user.id

        if @company.save
            redirect_to company_path(@company)
        else
            flash[:notice] = 'Não foi possível cadastrar a empresa'
            render 'new'
        end
    end
end