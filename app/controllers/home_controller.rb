class HomeController < ApplicationController

  def index
  end

  def show
    StartScrap.new.update
    set_crypto
  end

  def create
  StartScrap.new.perform
  redirect_to root_path
  end

  private

  def set_crypto
    @crypto_currency = CryptoCurrency.find(params[:CryptoCurrency][:id])
  end

  def crypto_params
    params.require(:crypto_currency).permit(:CryptoCurrency[:id], :name, :price)
  end

end
