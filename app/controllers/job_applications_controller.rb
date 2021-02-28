class JobApplicationsController < ApplicationController
    def search
        @job_application = JobApplication.where(job_id: Job.where(company_id: current_user.collaborator.company_id))
    end

    def accept
        @job_application = JobApplication.find(params[:id])
        @job_application.accepted!
        redirect_to search_job_application_path, notice: 'Você aceitou a candidatura'
    end

    def deny
        @job_application = JobApplication.find(params[:id])
        @job_application.denied!
        redirect_to search_job_application_path, notice: 'Você negou a candidatura'
    end
end