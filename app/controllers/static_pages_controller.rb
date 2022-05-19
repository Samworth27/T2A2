# frozen_string_literal: true

class StaticPagesController < ApplicationController
  before_action :authenticate_user!, except: [:index]
  def index; end
  def faq; end
  def about; end
end
