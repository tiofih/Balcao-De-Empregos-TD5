class JobApplicationsController < ApplicationController
    before_action :authenticate_user!
    def index
        @job_application = JobApplication.where(visitor_id: current_user.visitor.id)
    end

    def search
        @job_application = JobApplication.where(job_id: Job.where(company_id: current_user.collaborator.company_id))
    end

    def accept
        @job_application = JobApplication.find(params[:id])
        @job_application.accept_application(observation: params[:observation],
                                            salary: params[:salary],
                                            initial_date: params[:initial_date])
        redirect_to search_job_application_path, notice: 'Você aceitou a candidatura'
    end

    def visitor_accept
        @job_application = JobApplication.find(params[:id])
        @job_application.visitor_accept_application
        redirect_to job_applications_path, notice: 'Parabéns!'
    end

    def deny
        @job_application = JobApplication.find(params[:id])
        @job_application.deny_application(observation: params[:observation])
        redirect_to search_job_application_path, notice: 'Você negou a candidatura'
    end

    def visitor_deny
        @job_application = JobApplication.find(params[:id])
        @job_application.visitor_deny_application(observation: params[:observation])
        redirect_to job_applications_path, notice: 'Uma pena! Mas há outras vagas te esperando'
    end
end