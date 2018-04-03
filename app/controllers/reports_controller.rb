class ReportsController < ApplicationController
  def new
    @report = Report.new
  end

  def create
    @report = Report.new(report_params)
    
    respond_to do |format|
      if @report.save
        format.html { redirect_to users_path, notice: 'Report submitted.' }
        format.json { render :show, status: :created, location: @report.user_id }
      else
        format.html { render :new, notice: 'Report not submitted! Please try again.'}
        format.json { render json: @report.errors, status: :unprocessable_entity }
      end
    end
  end

  private

    def set_user
      @report = Report.find(params[:id])
    end

    def report_params
      params.require(:report).permit(:user_id, :report_message, :reported_id)
    end

end
