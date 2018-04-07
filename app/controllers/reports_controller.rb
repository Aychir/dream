class ReportsController < ApplicationController
  include UsersHelper

  before_action :require_login #You have to be logged in before you can do any of this

  def new
    @user = User.find(params[:format])
    if(@user != current_user && !current_user_has_reported(current_user.id, @user.id))
      @report = Report.new
    elsif @user == current_user
      redirect_to users_path, notice: 'You cannot report yourself...'
    else
      redirect_to users_path, notice: 'You cannot report this user again...'
    end
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

    def set_report
      @report = Report.find(params[:id])
    end

    def report_params
      params.require(:report).permit(:user_id, :report_message, :reported_id, :reported_type)
    end

end
