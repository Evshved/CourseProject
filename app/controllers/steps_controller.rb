require 'pry'
class StepsController < ApplicationController
  before_action :authenticate_user!, only: [:create, :update, :delete]

  def index
    @steps = Step.where(instruction_id: params[:instruction_id])
    @steps = @steps.all.page(params[:page]).per(5)
    new
  end

  def new
    @step = Step.new
  end

  def create
    instruction_id = parsing_http(request)
    @step = Step.new(instruction_id: instruction_id,
                     description: parsing_description(params))
    respond_to do |format|
      if @step.save
        format.html { redirect_to @step }
        format.json { render :show, status: :created, location: @step }
        format.js
      else
        format.html { render :new }
        format.json { render :json, @step.errors, status: :unprocessable_entity }
        format.js
      end
    end
  end

  def edit
  end

  def update
    @step = find_step
    respond_to do |format|
      if @step.update(step_params(params))
        format.html { redirect_to @step, notice: 'step was successfully updated.' }
        format.json { render :show, status: :ok, location: @step }
        format.js
      else
        format.html { render :edit }
        format.json { render json: @step.errors, status: :unprocessable_entity }
        format.js
      end
    end
  end

  def show
    # step_id = params[:id]
    @step = find_step
  end

  def destroy
    @step = find_step
    if @step.destroy
      respond_to do |format|
        format.html { redirect_to steps_path, notice: 'Post was successfully destroyed.' }
        format.json { head :no_content }
        format.js
      end
    else
      flash[:alert] = 'Error updating step!'
    end
  end

  private

  def find_step
    @step = Step.find(params[:id])
  end

  def parsing_description(params)
    @params = params
    @id = @params[:step]
    @id[:description]
  end

  def parsing_http(request)
    @request = request
    @request = @request.env["HTTP_REFERER"]
    index = @request.index('=') + 1
    @request = @request[index .. @request.length]
  end

  def step_params(params)
    params.require(:step).permit(:description)
    @step[:description] = parsing_description(params)
    @step
  end
end
