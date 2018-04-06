class ReportsController < ApplicationController

  before_action :require_login #You have to be logged in before you can do any of this

  def new
    @user = User.find(params[:format])
    if @user == current_user
      redirect_to users_path, notice: 'You cannot report yourself...'
    else     
      @report = Report.new
    end
  end

  def create
    begin
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
    rescue ActiveRecord::RecordNotUnique
        redirect_to users_path, notice: 'You cannot report a user more than once.' 
    end
  end

  private

    def set_report
      @report = Report.find(params[:id])
    end

    def report_params
      params.require(:report).permit(:user_id, :report_message, :reported_id, :reported_type)
    end

end
