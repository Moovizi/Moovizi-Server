class IssuesController < ApplicationController

  def index
    @issues = Issue.all
    
    render json: @issues, status: 200, method: :get
  end

  def show
    pattern = {id: true}

    if safe_params = valid_params(pattern, params)
      if issue = valid_object(Issue, safe_params[:id])
        render json: issue, status: 200, method: :get
      end
    end
  end

  def create
    pattern = {latitude: true, longitude: true, description: true, photo: false}

    if safe_params = valid_params(pattern, params)
      if issue = valid_request(Issue.new, safe_params)
        render json: issue, status: 201, method: :post
      end
    end
  end

  def update
    pattern = {id: true, latitude: false, longitude: false, description: false, photo: false}
    
    if safe_params = valid_params(pattern, params)
      if issue = valid_object(Issue, safe_params[:id])
        if updated = valid_request(issue, safe_params.except(:id))
          render json: issue, status: 200, method: :put
        end
      end
    end
  end

  def around
    pattern = {latitude: true, longitude: true, radius: true}

    if safe_params = valid_params(pattern, params)
      issues = Issue.near([params[:latitude], params[:longitude]], params[:radius], units: :km)
      render json: issues, status: 200, method: :get
    end
  end
  
end
