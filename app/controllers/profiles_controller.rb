class ProfilesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_profile, only: %i[show edit update destroy]
  def show
    @message = Message.new
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
    @profile = if params[:id]
                 Profile.find(params[:id])
               else
                 current_user.profile
               end
  end

  def profile_params
    params.fetch(:profile, {}).permit(%i[display_name first_name last_name country state suburb user_id])
  end
end
