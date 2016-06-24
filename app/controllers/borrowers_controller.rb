class BorrowersController < ApplicationController
  def index
  end
  def create
  	borrower = Borrower.new(borrower_params)
  	if borrower.save
  		session[:id] = borrower.id
  		session[:type] = "borrower"
  		session[:name] = "#{borrower.first_name} #{borrower.last_name}"
  		redirect_to "/borrowers/#{session[:id]}"
  	else
  		flash[:borrower_errors] = borrower.errors.full_messages
  		redirect_to :back
  	end
  end
  def show
  	if session[:id] != params[:id].to_i or session[:type] != "borrower"
  		redirect_to '/'
  	end
  	@borrower = Borrower.find(session[:id])
  	@join = Join.joins(:lender).where(borrower_id: session[:id]).select("*")
  	@sum = 0
  	@join.each do |e|
  		@sum += e.amount
  	end

  end
  private
  	def borrower_params
  		params.require(:borrower).permit(:first_name, :last_name, :email, :password, :password_confirmation, :amount_needed, :description, :need)
  	end
end
