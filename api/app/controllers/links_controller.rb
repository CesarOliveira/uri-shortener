class LinksController < ApplicationController

  def create
    @link = create_or_update_client.save

    return render :create unless @link[:errors]

    render json: @link, status: :unprocessable_entity
  rescue StandardError => e
    render json: { errors: e.message }, status: :unprocessable_entity
  end

  private

    def create_or_update_client
      Link::Create.new(
        link_params,
        LinkRepository
      )
    end

    def link_params
      params.permit(:destination_url)
    end
end
