class LinksController < ApplicationController
  def create
    @link = create_link.save

    return render :create, status: :created unless @link[:errors]

    render json: @link, status: :unprocessable_entity
  rescue StandardError => e
    render json: { errors: e.message }, status: :unprocessable_entity
  end

  private

    def create_link
      Link::Create.new(
        link_params,
        LinkRepository
      )
    end

    def link_params
      params
        .require(:link)
        .permit(:destination_url)
    end
end
