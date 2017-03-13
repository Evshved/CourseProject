class StepsController < ApplicationController
  def index
     @steps = Step.where(instruction_id: params[:instruction_id])
     @can_edit = false
     new
  end

  def new
     @step = Step.new
     @photo = Photo.new
  end

  def create
     if parsing_photo(params) != ''
       @photo = save_photo
       return true
     end
     create_step
  end

  def edit
  end

  def update
    if parsing_photo(params) != ''
       @photo = save_photo
       return true
    end
    @step = find_step
    respond_to do |format|
       if @step.update(step_params)
         format.html { render 'steps/#{@step.id}' }
         format.json { render json: @step }
         format.js
       else
         format.html { render :edit }
         format.json { render json: @step.errors, status: :unprocessable_entity }
         format.js { render 'steps/index'}
       end
     end
    photo = Photo.where(user_id: current_user.id, has_connection: false).last
    photo.has_connection = true
    photo.save
  end

  def show
     @can_edit = true
     @step = find_step
  end

  def destroy
    @step = find_step
    if @step.destroy
       respond_to do |format|
         format.html { render steps_path }
         format.json { head :no_content }
         format.js
       end
    end
  end

  private

  def create_step
    instruction_id = parsing_http(request)
    @step = Step.new(instruction_id: instruction_id,
                      description: parsing_description(params),
                      image: choose_photo,
                      user_id: current_user.id)
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

   def choose_photo
      Photo.where(user_id: current_user.id, has_connection: false).last[:image]
   end

   def save_photo
     image = select_image
     @photo = Photo.new(user_id: current_user.id,
                        image: image,
                        has_connection: false)
     @photo.save
   end

  def select_image
    param = params[:photo]
    url = param[:image]
    url[0..param[:image].index('#') - 1]
  end

  def find_step
    @step = Step.find(params[:id])
  end

  def parsing_photo(params)
    @params = params
    @id = @params[:photo]
    return '' if @id == nil
    @id[:image]
  end

  def parsing_description(params)
    text = params[:step]
    text[:description]
  end

  def parsing_http(request)
     @request = save_url(request)
     index = @request.index('=') +  1
     @request = @request[index .. @request.length]
  end

  def save_url(request)
    request.env["HTTP_REFERER"]
  end

  def check_step
    index = save_url(request).index('steps') + 5
    url = save_url(request)
    url[index] == '?' ? true : false
  end

  def step_params
    hash_of_params = {}
    hash_of_params[:description] = parsing_description(params)
    hash_of_params[:image] = Photo.where(user_id: current_user.id,
                                has_connection: false).last.image
    hash_of_params[:user_id] = current_user.id
    hash_of_params
  end
end
