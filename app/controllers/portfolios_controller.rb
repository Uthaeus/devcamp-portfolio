class PortfoliosController < ApplicationController
  before_action :set_portfolio_item, only: [:edit, :update, :show, :destroy]
  access all: [:show, :index, :angular], user: {except: [:destroy, :new, :create, :update, :edit, :sort]}, site_admin: :all
  layout 'portfolio'
  def index
    @portfolio_items = Portfolio.by_position
  end

  def sort
    params[:order].each do |key, value|
      Portfolio.find(value[:id]).update(position: value[:position])
    end

    head :ok
  end

  def new
    @portfolio_item = Portfolio.new
    3.times { @portfolio_item.technologies.build }
  end

  def angular
    @angular_portfolio_items = Portfolio.angular
  end


 def create
    @portfolio_item = Portfolio.new(portfolio_params)

    respond_to do |format|
      if @portfolio_item.save
        format.html { redirect_to portfolios_path, notice: 'Portfolio was successfully created.' }
        format.json { render :show, status: :created, location: @portfolio_item }
      else
        format.html { render :new }
        format.json { render json: @portfolio_item.errors, status: :unprocessable_entity }
      end
    end
  end

  def edit
    3.times { @portfolio_item.technologies.build }
  end

  def update
    
    respond_to do |format|
        if @portfolio_item.update(portfolio_params)
            format.html { redirect_to portfolios_path, notice: 'Portfolio was successfully updated.' }
            
          else
            format.html { render :edit }
            
          end
        end
    end

    def show
        
    end

    def destroy
      #perform the lookup


      @portfolio_item.destroy

      #redirect
      respond_to do |format|
        format.html { redirect_to portfolios_url, notice: 'Portfolio was successfully destroyed.' }
        
      
    end
  end

  private

  def portfolio_params
    params.require(:portfolio).permit(:title, 
                                      :subtitle, 
                                      :body, 
                                      technologies_attributes: [:name]
                                      )
  end
  def set_portfolio_item
    @portfolio_item = Portfolio.find(params[:id])
  end

end