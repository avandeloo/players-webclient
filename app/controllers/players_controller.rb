class PlayersController < ApplicationController
  
  def index
    @players = Player.all
  end

  def new
    @player = Player.new
  end

  def create
    @player = Player.create(
                            first_name: params[:first_name],
                            last_name: params[:last_name],
                            birthdate: params[:birthdate],
                            pro_team: params[:pro_team],
                            position: params[:position],
                            salary: params[:salary],
                            location: params[:location],
                            quote: params[:quote]
                          )

    redirect_to "/players/#{@player.id}"
  end

  def show
    @player = Player.find(params[:id])
  end

  def edit
    @player = Player.find(params[:id])   
  end

  def update
    @player = Player.find(params[:id])

    @player.update(
                    first_name: params[:first_name],
                    last_name: params[:last_name],
                    birthdate: params[:birthdate],
                    pro_team: params[:pro_team],
                    position: params[:position],
                    salary: params[:salary],
                    location: params[:location],
                    quote: params[:quote]
                  )
    
    redirect_to "/players/#{@player.id}"
  end

  def destroy
    @player = Player.find(params[:id])
    @player.destroy

    redirect_to "/players"
  end

end
