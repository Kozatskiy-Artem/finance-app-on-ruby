class ReportsController < ApplicationController
  before_action :validate_date, only: %i[ report ]

  def index
  end

  def report
    if params[:commit] == "date"
      redirect_to({action: "report_by_dates", start_date: @start_date, end_date: @end_date})
    else
      puts params
      redirect_to({action: "report_by_category", start_date: @start_date, end_date: @end_date})
    end
  end

  def report_by_category
    @background_colors = []
    @categories = []
    @amounts = []
  
    # 4.times do
    #   @background_colors.append("rgb(#{rand(255)}, #{rand(255)}, #{rand(255)})")
    # end

    operations = Operation.where("odate >= :start_date AND odate <= :end_date", 
                        {start_date: params[:start_date], end_date: params[:end_date]}).order(:odate)
    categories_and_amount = {}
    operations.each do |oper|
      if categories_and_amount.has_key?(oper.category.name)
        categories_and_amount[oper.category.name] += oper.amount
      else
        categories_and_amount[oper.category.name] = oper.amount
      end
    end

    categories_and_amount.each do |key, value|
      @categories.append(key)
      @amounts.append(value)
      @background_colors.append("rgb(#{rand(255)}, #{rand(255)}, #{rand(255)})")
    end

    if @categories == []
      respond_to do |format|
        format.html { redirect_to reports_url, notice: "Operations for the period [#{params[:start_date]} - #{params[:end_date]}] not found." }
      end
    end
  end

  def report_by_dates
    @dates = []
    @amount = []
    @start = params[:start_date].to_s
    @end = params[:end_date].to_s
    operations = Operation.where("odate >= :start_date AND odate <= :end_date", 
                        {start_date: params[:start_date], end_date: params[:end_date]}).order(:odate)
    
    prev_date = ''
    operations.each do |oper|
      if prev_date == oper.odate.to_s
        @amount[-1] += oper.amount
      else
        @dates.append(oper.odate.to_s)
        @amount.append(oper.amount)
      end
      prev_date = oper.odate.to_s
    end
    if @amount == []
      respond_to do |format|
        format.html { redirect_to reports_url, notice: "Operations for the period [#{params[:start_date]} - #{params[:end_date]}] not found." }
      end
    end
  end

  def validate_date
    @start_date = params[:date_start]
    @end_date = params[:date_end]
    if params[:date_start] == ''
      @start_date = Operation.order(:odate).first.odate
    end
    if params[:date_end] == ''
      @end_date = Operation.order(:odate).last.odate
    end
    if @start_date > @end_date
      @start_date, @end_date = @end_date, @start_date
    end
  end

end
