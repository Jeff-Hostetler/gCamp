class API

  def initialize
    @conn = Faraday.new(:url => 'https://www.pivotaltracker.com')
  end

  def pivotal_projects(current_user)

    response = @conn.get do |req|
      req.url "/services/v5/projects"
      req.headers['Content-Type'] = 'application/json'
      req.headers['X-TrackerToken'] = current_user.pivotal_token
    end

      json_response = JSON.parse(response.body, symbolize_names: true)

  end
end
