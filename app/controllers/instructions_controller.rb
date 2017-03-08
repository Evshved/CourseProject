require 'pry'
class InstructionsController < ApplicationController
  before_action :authenticate_user!, only: [:create, :update, :delete]
  before_action :set_auth
  before_action :find_instruction, only: [:edit, :update, :show, :delete]
  autocomplete  :tag, :name, display_value: :camelize

  def index
    if params[:tag]
      @instructions = Instruction.tagged_with(params[:tag])
    else
      @instructions = Instruction.order(created_at: :desc)
    end
    @instructions = @instructions.page(params[:page]).per(6)
    new
  end

  def new
    @instruction = Instruction.new
  end

  def create
    @instruction = Instruction.new(instruction_params)
    respond_to do |format|
      if @instruction.save
        format.html { redirect_to @instruction }
        format.json { render :show, status: :created, location: @instruction }
        format.js
      else
        format.html { render :new}
        format.json { render :json, @instruction.errors, status: :unprocessable_entity }
        format.js
      end
    end
  end

  def edit
  end

  def update
    respond_to do |format|
      if @instruction.update(instruction_params)
        format.html { redirect_to @instruction, notice: 'instruction was successfully updated.' }
        format.json { render :show, status: :ok, location: @instruction }
        format.js
      else
        format.html { render :edit }
        format.json { render json: @instruction.errors, status: :unprocessable_entity }
        format.js
      end
    end
  end

  def show
    redirect_to controller: 'steps', action: 'index',
                instruction_id: @instruction.id
  end

  def destroy
    @instruction = find_instruction
    if @instruction.destroy
      respond_to do |format|
        format.html { redirect_to instructions_path, notice: 'Post was successfully destroyed.' }
        format.json { head :no_content }
        format.js
      end
    else
      flash[:alert] = 'Error updating Instruction!'
    end
  end


  private

  def instruction_params
    instruction = params.require(:instruction).permit(:title,
                                               :youtube_link, :all_tags)
    hash_params = fill_params(instruction)
    hash_params[:user_id] = current_user[:id].to_s
    hash_params
  end

  def fill_params(instruction)
    { title: instruction[:title],
      youtube_link: instruction[:youtube_link],
      all_tags: instruction[:all_tags] }
  end

  def find_instruction
    @instruction = Instruction.find(params[:id])
  end

  def set_auth
    @auth = session[:omniauth] if session[:omniauth]
  end
end
