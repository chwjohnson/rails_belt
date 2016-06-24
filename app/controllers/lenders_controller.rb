class LendersController < ApplicationController
  def index
  end
  def create
  	lender = Lender.new(lender_params)
  	if lender.save
  		session[:id] = lender.id
  		session[:type] = "lender"
  		session[:name] = "#{lender.first_name} #{lender.last_name}"
  		redirect_to "/lenders/#{session[:id]}"
  	else
  		flash[:lender_errors] = lender.errors.full_messages
  		redirect_to :back
  	end
  end
  def show
  	if session[:id] != params[:id].to_i or session[:type] != "lender"
  		redirect_to '/'
  	end
  	@lender = Lender.find(session[:id])
  	sum = 0
  	@join = Join.joins(:borrower).select("*")
  	@join.each do |lent|
  		if lent.lender_id == session[:id]
  			sum += lent.amount
  		end
  	end
  	@lender.money -= sum
  	@all = Borrower.all
 	@borrower = Borrower.joins(:lenders).select("borrowers.first_name as first_name", "borrowers.last_name as last_name", :need, :description, :amount_needed, :lender_id, :borrower_id, :amount, :id)
  	# render json: @all
  end
  def update
  	join1 = Join.find_by(borrower_id: params[:id])
  	sum = 0
  	join = Join.joins(:borrower).select("*")
  	join.each do |lent|
  		if lent.lender_id == session[:id]
  			sum += lent.amount
  		end
  	end
  	lender = Lender.find(session[:id])
  	lender.money -= sum
  	if lender.money >= params[:amount].to_i
	  	if join1
	  		new_amount = join1.amount + params[:amount].to_i
	  		join1.update(amount: new_amount)
	  	else
	  		join1 = Join.create(lender_id: session[:id], borrower_id: params[:id], amount: params[:amount])
	  	end
	else
		flash[:errors] = "Insufficient Funds!"
	end
  	redirect_to :back
  end
  private
  	def lender_params
  		params.require(:lender).permit(:first_name, :last_name, :email, :password, :password_confirmation, :money)
  	end
end
