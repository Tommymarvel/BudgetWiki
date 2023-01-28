class SplashScreenController < ApplicationController
  before_action :some_method, only: [:index]
  def some_method
    return unless user_signed_in?

    redirect_to categories_path
    nil
  end
end
