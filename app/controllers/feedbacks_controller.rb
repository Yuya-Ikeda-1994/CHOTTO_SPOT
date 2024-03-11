class FeedbacksController < ApplicationController

    def create
      @spot = Spot.find(params[:spot_id]) 
      @feedback = current_user.feedbacks.build(feedback_params)
      respond_to do |format|
        if @feedback.save
          format.js 
        else
          format.js
        end
      end
    end

    def edit
      @feedback = current_user.feedbacks.find(params[:id])
      respond_to do |format|
        format.js
      end
    end


    def update
      @feedback = current_user.feedbacks.find(params[:id])
      respond_to do |format|
        if @feedback.update(feedback_update_params)
          format.js
        else
          format.js { render 'edit' }
        end
      end
    end


    def destroy
      @feedback = current_user.feedbacks.find(params[:id])
      respond_to do |format|
        @feedback.destroy
          format.js
      end
    end
    
    private
  
    def feedback_params
      params.require(:feedback).permit(:feedback_comment).merge(spot_id: params[:spot_id])
    end

    def feedback_update_params
      params.require(:feedback).permit(:feedback_comment)
    end
end
