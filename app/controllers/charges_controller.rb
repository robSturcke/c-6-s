class ChargesController < ApplicationController
  def create
   # Creates a Stripe Customer object, for associating
   # with the charge
   customer = Stripe::Customer.create(
     email: current_user.email,
     card: params[:stripeToken]
   )

   # Where the real magic happens
   charge = Stripe::Charge.create(
     customer: customer.id, # Note -- this is NOT the user_id in your app
     amount: Amount.default,
     description: "Help keep the Cayde-6 Project  - #{current_user.email}",
     currency: 'usd'
   )

   flash[:notice] = "Thanks for your support, #{current_user.email}! Feel free to support us again!"
   redirect_to user_path(current_user) # or wherever

   # Stripe will send back CardErrors, with friendly messages
   # when something goes wrong.
   # This `rescue block` catches and displays those errors.
   rescue Stripe::CardError => e
     flash[:alert] = e.message
     redirect_to new_charge_path
 end

  def new
    @stripe_btn_data = {
      key: "#{ Rails.configuration.stripe[:publishable_key] }",
      description: "Cayde-6 Sect Support - #{current_user.email}",
      amount: Amount.default
    }
  end

  class Amount
    def self.default
      1500
    end
  end
end
