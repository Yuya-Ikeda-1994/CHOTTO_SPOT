class FeedbacksController < ApplicationController

    def create
      @spot = Spot.find(params[:spot_id]) # これは@feedbackを保存する前に適切なスポットを見つけるための例です。
      @feedback = current_user.feedbacks.build(feedback_params)
      @feedback.spot = @spot
      respond_to do |format|
        if @feedback.save
          format.js 
        else
          format.js
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
end
