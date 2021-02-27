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
            flash[:notice] = t('.error')
            render 'new'
        end
    end

    def search
        @job = Job.where('title like ?', "%#{params[:q]}%")
    end

    def apply 
        @job = Job.find(params[:id])
        if current_user != nil
            @job.apply(current_user.visitor.ids.first)
            redirect_to job_path(@job), notice: t('.success')
        else
            redirect_to new_user_session_path, notice: t('.error')
        end
    end
end