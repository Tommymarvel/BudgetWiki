class EntitiesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_entity, only: %i[show edit update destroy]

  def index
    @category = Category.find_by(id: params[:category_id])
    if @category
      @entities = @category.entities
    else
      flash[:alert] = 'Invalid category id'
      redirect_to categories_path
    end
  rescue ActiveRecord::RecordNotFound
    flash[:alert] = 'Invalid category id'
    redirect_to categories_path
  end

  # GET /entities/1 or /entities/1.json
  def show; end

  # GET /entities/new
  def new
    @entity = Entity.new
    @category = Category.find(params[:category_id])
  end

  # GET /entities/1/edit
  def edit; end

  # POST /entities or /entities.js  before_action :authenticate_user!on
  def create
    @entity = Entity.new(entity_params)
    @entity.user_id = current_user.id

    respond_to do |format|
      if @entity.save
        @category_entity = CategoryEntity.new(category_id: params[:category_id], entity_id: @entity.id)
        @category_entity.save
        format.html { redirect_to category_entities_path(params[:category_id]), notice: 'Entity was successfully created.' }
        format.json { render :show, status: :created, location: @entity }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @entity.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /entities/1 or /entities/1.json
  def update
    respond_to do |format|
      if @entity.update(entity_params)
        format.html { redirect_to category_entity_path(@category, @entity), notice: 'Entity was successfully updated.' }
        format.json { render :show, status: :ok, location: @entity }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @entity.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /entities/1 or /entities/1.json
  def destroy
    @entity.destroy
    respond_to do |format|
      format.html { redirect_to category_entities_path(@category), notice: 'Entity was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

  def set_entity
    @entity = Entity.find(params[:id])
  end

  def entity_params
    params.require(:entity).permit(:name, :amount)
  end
end
