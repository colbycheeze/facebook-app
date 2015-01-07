class StaticPagesController < ApplicationController
  before_filter :redirect_if_not_signed_in

  def home
  end
end
