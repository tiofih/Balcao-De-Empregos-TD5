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
        job_params = params.require(:job).permit(:title,
                                                :description,
                                                :salary_range,
                                                :level,
                                                :requirements,
                                                :deadline,
                                                :total_vacancies)
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

    def apply 
        @job = Job.find(params[:id])
        if current_user != nil
            @job.apply(@job.id, current_user.id)
            redirect_to job_path(@job), notice: 'Parabéns, você está concorrendo a vaga!"'
        else
            redirect_to new_user_session_path, notice: 'Você deve se cadastrar para se candidatar a vagas'
        end
    end
end