class VisitorsController < ApplicationController
    def show
        @visitor = Visitor.find(params[:id])
    end

    def new
        @visitor = Visitor.new
    end

    def create
        visitor_params = params.require(:visitor).permit(:name,
                                                :cpf,
                                                :phone,
                                                :bio,
                                                :github)
        @visitor = Visitor.new(visitor_params)
        @visitor.user_id = current_user.id
        @visitor.save
        redirect_to visitor_path(Visitor.last)
    end
end