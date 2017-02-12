class PlayersController < ApplicationController
  
  def index
    @players = Unirest.get("http://localhost:3000/api/v1/players.json").body
  end

  def create
    @player = Unirest.post("http://localhost:3000/api/v1/players", headers:{ "Accept" => "application/json" }, parameters:{ first_name: params[:first_name], last_name: params[:last_name], position: params[:position], pro_team: params[:pro_team]}).body
    
    redirect_to "/players/#{@player["id"]}"
  end

  def show
    @player = Unirest.get("http://localhost:3000/api/v1/players/#{params[:id]}.json").body
  end

  def edit
    @player = Unirest.get("http://localhost:3000/api/v1/players/#{params[:id]}.json").body    
  end

  def update
    @player = Unirest.patch("http://localhost:3000/api/v1/players/#{params[:id]}", headers:{ "Accept" => "application/json" }, parameters:{ first_name: params[:first_name], last_name: params[:last_name], position: params[:position], pro_team: params[:pro_team]}).body
    
    redirect_to "/players/#{@player["id"]}"
  end

  def destroy
    @player = Unirest.delete("http://localhost:3000/api/v1/players/#{params[:id]}", headers:{ "Accept" => "application/json" }, parameters:{ first_name: params[:first_name], last_name: params[:last_name], position: params[:position], pro_team: params[:pro_team]}).body

    redirect_to "/players"
  end

end
