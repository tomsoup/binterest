class PinsController < ApplicationController
  before_action :find_pin, only: [:show, :edit, :update, :destroy, :upvote]
  before_action :authenticate_user!, except: [:index, :show]
  before_action :check_user, only: [:destroy, :update, :edit]

  def index
    @pins = Pin.all.order('created_at DESC')
  end

  def seller
    @pins = Pin.where(user: current_user).order('created_at DESC')
  end

  def new
    @pin = Pin.new
  end

  def create
    @pin = Pin.new(pin_params)
    @pin.user = current_user

    if current_user.recipient.blank?

      Stripe.api_key = ENV['STRIPE_API_KEY']
      token = params[:stripeToken]

      recipient = Stripe::Account.create(
        {
          :country => "US",
          :managed => true
        }
      )

      account = Stripe::Account.retrieve(recipient.id)


      account.external_accounts.create({
        :bank_account => token
      })

    end
    
    current_user.recipient = recipient.id
    current_user.save

    if @pin.save
      redirect_to @pin, notice: 'Successfully created new Pin!'
    else
      render 'new'
    end
  end

  def show
  end

  def edit
  end

  def update
    if @pin.update(pin_params)
      redirect_to @pin, notice: 'Pin was Successfully updated!'
    else
      render 'edit'
    end
  end

  def destroy
    @pin.destroy
    redirect_to root_path
  end

  def upvote
    @pin.upvote_by current_user
    redirect_to :back
  end

  private

  def pin_params
    params.require(:pin).permit(:title, :price, :description, :image, :user_id)
  end

  def find_pin
    @pin = Pin.find(params[:id])
  end

  def check_user
    if current_user != @pin.user
      redirect_to root_url, alert: 'Sorry, this pin belongs to someone else'
    end
  end
end
