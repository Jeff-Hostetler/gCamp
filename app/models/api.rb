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

  def pivotal_single_project(current_user, project_id)
    response = @conn.get do |req|
      req.url "/services/v5/projects/#{project_id}"
      req.headers['Content-Type'] = 'application/json'
      req.headers['X-TrackerToken'] = current_user.pivotal_token
    end

    json_response = JSON.parse(response.body, symbolize_names: true)
  end

  def pivotal_stories(current_user, project_id)
    response = @conn.get do |req|
      req.url "https://www.pivotaltracker.com/services/v5/projects/#{project_id}/stories?limit=500"
      req.headers['Content-Type'] = 'application/json'
      req.headers['X-TrackerToken'] = current_user.pivotal_token

    end

    json_response = JSON.parse(response.body, symbolize_names: true)
  end

end
