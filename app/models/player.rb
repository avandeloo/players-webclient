class Player
  HEADERS = {
              "Accept" => "application/json",
              "X-User-Email" => ENV['API_EMAIL'],
              "Authorization" => "Token token=#{ ENV['API_TOKEN'] }"
              }
            
  attr_accessor :id, :first_name, :last_name, :position, :birthday, :pro_team, :salary, :location, :quote

  def initialize(hash={})
    @id = hash["id"]
    @first_name = hash["first_name"]
    @last_name = hash["last_name"]
    @position = hash["position"]
    if hash["birthday"]
      @birthday = Date.parse(hash["birthday"])
    else
      @birthday = nil
    end
    @pro_team = hash["pro_team"]
    @salary = hash["salary"]
    @location = hash["location"]
    @quote = hash["quote"]
    
  end

  def fullname
    "#{first_name} #{last_name}"
  end

  def friendly_birthday
    if birthday
      birthday.strftime('%m/%d/%Y')
    else
      "No Birthday Listed"
    end
  end

  def self.all
    player_collection = []
    api_players = Unirest.get(
                              "#{ ENV['API_HOST_URL'] }/api/v1/players.json",
                              headers: HEADERS
                              ).body
    
    api_players.each do |player_hash|
      player_collection << Player.new(player_hash)
    end

    player_collection

  end

  def self.find(player_id)
    Player.new(Unirest.get(
                            "#{ ENV['API_HOST_URL'] }/api/v1/players/#{player_id}.json", 
                            headers: HEADERS
                            ).body)
  end

  def update(player_info)

    response_body = Unirest.patch(
                            "#{ ENV['API_HOST_URL'] }/api/v1/players/#{id}", 
                            headers: HEADERS, 
                            parameters: player_info
                            ).body
    Player.new(response_body)

  end

  def self.create(player_info)
    response_body = Unirest.post(
                            "#{ ENV['API_HOST_URL'] }/api/v1/players", 
                            headers: HEADERS, 
                            parameters: player_info
                            ).body
    
    Player.new(response_body)

  end

  def destroy
    Unirest.delete(
                    "#{ ENV['API_HOST_URL'] }/api/v1/players/#{id}", 
                    headers: HEADERS
                  ).body
  end

end