# frozen_string_literal: true

class ScaffoldsController < ApplicationController
  before_action :set_scaffold, only: %i[show edit update destroy]

  # GET /scaffolds or /scaffolds.json
  def index
    @scaffolds = Scaffold.all
  end

  # GET /scaffolds/1 or /scaffolds/1.json
  def show; end

  # GET /scaffolds/new
  def new
    @scaffold = Scaffold.new
  end

  # GET /scaffolds/1/edit
  def edit; end

  # POST /scaffolds or /scaffolds.json
  def create
    @scaffold = Scaffold.new(scaffold_params)

    respond_to do |format|
      if @scaffold.save
        format.html { redirect_to scaffold_url(@scaffold), notice: 'Scaffold was successfully created.' }
        format.json { render :show, status: :created, location: @scaffold }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @scaffold.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /scaffolds/1 or /scaffolds/1.json
  def update
    respond_to do |format|
      if @scaffold.update(scaffold_params)
        format.html { redirect_to scaffold_url(@scaffold), notice: 'Scaffold was successfully updated.' }
        format.json { render :show, status: :ok, location: @scaffold }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @scaffold.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /scaffolds/1 or /scaffolds/1.json
  def destroy
    @scaffold.destroy

    respond_to do |format|
      format.html { redirect_to scaffolds_url, notice: 'Scaffold was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_scaffold
    @scaffold = Scaffold.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def scaffold_params
    params.fetch(:scaffold, {})
  end
end
