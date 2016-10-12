class ShortUrlsController < ApplicationController
  before_action :authenticate,:except =>  [:show]

  # GET /short_urls
  def index
    @short_urls = paginate @current_user.short_urls, per_page: 5
    render json: @short_urls.as_json(only:[:original_url,:shorty,:visits])
  end

  # GET /short_urls/1
  def show
    shorty = ShortUrl.find_by(shorty: params.require(:shorty))
    if shorty.present?
      shorty.increment_counter(request.remote_ip)
      redirect_to shorty.original_url
    else
      render json: {:error => "not-found"}, :status => 404
    end
  end

  # POST /short_urls
  def create
    @short_url = @current_user.short_urls.new(short_url_params)
    if @short_url.save
      render json: {:original_url => @short_url.original_url, :shorty => @short_url.display_shorty }, status: :created, location: @short_url.display_shorty
    else
      render json: @short_url.errors, status: :unprocessable_entity
    end
  end

  # DELETE /short_urls/1
  def destroy
    short_url = @current_user.short_urls.find_by(shorty: params[:id])
    if short_url.present?
      short_url.destroy
      render json: "Destroyed Short URL !!!", status: :ok
    else
      render json: {:status => "Shorty Link Not Found" }, status: :not_found
    end
  end

  def extract
    shorty = @current_user.short_urls.find_by(shorty: shorty_params)
    if shorty.present?
      render json: parse_geo_details_for(shorty),status: :ok
    else
      render json: {:status => "Shorty Link Not Found" }, status: :not_found
    end
  end

  private
  # Only allow a trusted parameter "white list" through.
  def short_url_params
    params.permit(:original_url)
  end

  def shorty_params
    params.require(:shorty)
  end

  # Fetch GeoLocation Details from freegeoip.net
  def parse_geo_details_for(link)
    visitor_ips = paginate link.short_visits ,per_page: 10
    # Loop over the paginated IPS to fetch Details
    location_details = visitor_ips.collect do |visitor|
      url = "http://freegeoip.net/json/" + visitor.visitor_ip
      response = UrlSource.new(url).stream_response
      if response[:status] == "OK"
        geo_hash = {}
        parsed_json = JSON.parse(response[:body])
        geo_hash[:visitor_ip] = parsed_json["ip"]
        geo_hash[:visitor_city] = parsed_json["city"]
        geo_hash[:visitor_state] = parsed_json["region_name"]
        geo_hash[:visitor_country] = parsed_json["country_name"]
        geo_hash[:visitor_zip] = parsed_json["zip_code"]
        visitor.update_attributes(geo_hash)
        geo_hash[:original_url] = link.original_url
        geo_hash[:short_url] = link.shorty
      else
        geo_hash = {:error => "Unable to Process Data from freegeoip for #{visitor_ip}"}
      end
      geo_hash
    end
    return location_details
  end
end