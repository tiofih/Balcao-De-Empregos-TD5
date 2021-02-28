class JobApplicationsController < ApplicationController
    def search
        @job_application = JobApplication.all
    end

    def accept
        
    end
end