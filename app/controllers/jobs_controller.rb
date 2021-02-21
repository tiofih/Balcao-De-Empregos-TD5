class JobsController < ApplicationController
    def index
        @job = Job.all
    end

    def show
        @job = Job.find(params[:id])
    end

    def new
        @job = Job.new
    end

    def create
        job_params = params.require(:job).permit(:title, :description, :salary_range, :level, :requirements, :deadline, :total_vacancies)
        @job = Job.new(job_params)

        if @job.save
            redirect_to job_path(@job)
        else
            flash[:notice] = 'Alguns campos não podem ficar em branco'
            render new_job_path
        end
    end

    def search
        @job = Job.where('title like ?', "%#{params[:q]}%")
    end
end