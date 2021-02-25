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
        if @visitor.save
            redirect_to visitor_path(Visitor.last)
        else
            flash[:notice] = 'Alguns campos não podem ficar em branco, veja abaixo:'
            render 'new'
        end
    end
end