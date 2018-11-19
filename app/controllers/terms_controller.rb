class TermsController < ApplicationController
  before_action :authenticate_user!
  
  def new
    @terms = Term.new
  end

  def create
    @terms = Term.new(terms_params)
    @terms.user = current_user

    if @terms.save
      flash[:notice] = "Thanks & Welcome!"
      redirect_to users_path
    else
      flash[:notice] = "There was an error, please try again"
      render :new
    end
  end

  private

  def terms_params
    params.require(:term).permit(:agree)
  end
end
