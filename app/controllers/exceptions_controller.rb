class ExceptionsController < ApplicationController
  respond_to :json, :js, :html, :xml
  skip_before_action :authenticate_user!
  before_action :status
  layout :layout

  def show
    puts "Show"
    respond_with status: @status
  end

  protected

  def status
    @exception  = env['action_dispatch.exception']
    @status     = ActionDispatch::ExceptionWrapper.new(env, @exception).status_code
    @response   = ActionDispatch::ExceptionWrapper.rescue_responses[@exception.class.name]
  end

  #Format
  def details
    @details ||= {}.tap do |h|
      I18n.with_options scope: [:exception, :show, @response], exception_name: @exception.class.name, exception_message: @exception.message do |i18n|
        h[:name]    = i18n.t "#{@exception.class.name.underscore}.title", default: i18n.t(:title, default: @exception.class.name)
        h[:message] = i18n.t "#{@exception.class.name.underscore}.description", default: i18n.t(:description, default: @exception.message)
      end
    end
  end
  helper_method :details

  private

  #Layout
  def layout_status
    puts "Hey"
    @status.to_s >= "400" ? "application" : "error"
  end
end
