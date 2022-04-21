class Api::DistancesController < ApplicationController

	def index
		distances = current_user.distances
		if params[:search_params].present?
			query = params[:search_params].to_s.downcase
			distances = distances.where("lower(distances.source_location) LIKE '%#{query}%' OR lower(distances.destination_location) LIKE '%#{query}%'").order("LOWER(distances.source_location)")
		end
    render json: {data: distances, message: "Success"}, status: 200
	end
	
	# testing params in postman
  # {"distance": {"source_location": "source_location1", "destination_location": "destination_location", "distance_range": {"km": 1, "miles": 1.6}}
	def create
    distance = Distance.new(create_params)
    distance.user_id = current_user.id
    distance.distance_range = params[:distance][:distance_range]
    if distance.save
      render json: {data: distance, message: "Success"}, status: 200
    else
      render json: {errors: distance.errors.full_messages}, status: 400
    end
  end

  private

  def create_params
  	params.require(:distance).permit(:source_location, :destination_location, :distance_range)
  end
end
