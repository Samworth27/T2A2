class ProfilesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_profile, only: %i[show edit update destroy]
  def show

  end

  def new
    redirect_to own_profile_path if current_user.profile.nil? == false
    @profile = Profile.new
  end

  def edit
    @profile = Profile.new if current_user.profile.nil? == true
  end

  def create
    @profile = Profile.new(profile_params)
    @profile.user = current_user

    respond_to do |format|
      if @profile.save
        format.html { redirect_to profiles_url(@profile), notice: 'profile was successfully created.' }
      else
        format.html { render :new, status: :unprocessable_entity }
      end
    end
  end

  def update
    if @profile.update(profile_params)
      redirect_to own_profile_path, notice: 'Profile has been updated'
    else
      # flash[:alert] = profile.errors.full_messages.join('<br>')
      # render 'edit'
      flash.now[:error] = 'Profile could not be updated'
      render :edit, status: :unprocessable_entity
    end
  end

  def set_profile
    if params[:id]
      @profile = Profile.find(params[:id])
    else
      @profile = current_user.profile
    end
  end


end
