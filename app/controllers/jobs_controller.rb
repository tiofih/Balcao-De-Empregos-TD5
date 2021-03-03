class JobsController < ApplicationController
    def index
        @job = Job.all
    end

    def show
        @job = Job.find(params[:id])
    end

    def search
        @job = Job.where('title like ?', "%#{params[:q]}%")
    end

    before_action :authenticate_user!, :only => [:new, :create, :apply, :edit]
    def new
        @job = Job.new
    end

    def edit
        @job = Job.find(params[:id])
    end

    def update
        @job = Job.find(params[:id])
        if @job.update(job_params)
            redirect_to job_path(@job)
        else
            flash[:notice] = 'Alguns campos não podem ficar em branco, veja abaixo:'
            render 'edit'
        end
    end

    def create
        @job = Job.new(job_params)
        @job.company_id = current_user.collaborator.company_id

        if @job.save
            redirect_to job_path(@job)
        else
            flash[:notice] = t('.error')
            render 'new'
        end
    end

    def apply 
        @job = Job.find(params[:id])
        if current_user != nil
            @job.apply(current_user.visitor.id)
            redirect_to job_path(@job), notice: t('.success')
        end
    end

    private
    def job_params
        job_params = params.require(:job).permit(:title,
                                                :description,
                                                :salary_range,
                                                :level,
                                                :requirements,
                                                :deadline,
                                                :total_vacancies,
                                                :company_id)
    end
end