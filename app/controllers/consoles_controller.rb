## Authors: Ayan Ahmad (K19002255), Kevin Quah (k1921877), Jae Min An (k19034574), Daniela Stanciu (k1922053), Mihaela Peneva (k19026170) 

class ConsolesController < ApplicationController
  # Before Processing the Requested Action, Call logged_in_user_admin
  before_action :logged_in_user_admin

  def index
    # fetch the first row in the table and make it accesable for the view
    @console = Console.find(1)
  end

  def update
    # The UI Values at the requested row are edited and updated here
    @console = Console.find(params[:id])

    # Only certain fields are allowed to be passed throguh
    if @console.update(console_params)
      redirect_to (consoles_path)
    else
      render('index')
    end
  end

  private
  def console_params
    # Only allow certain post params
    params.require(:console).permit(:footer_b, :footer_t, :header_b, :header_t, :corona_b, :corona_t, :banner_b, :banner_t)
  end
end
