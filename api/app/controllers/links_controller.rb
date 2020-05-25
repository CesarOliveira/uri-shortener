class LinksController < ApplicationController
  include ActionController::Cookies

  def create
    @link = create_link.save

    return render :create, status: :created unless @link[:errors]

    render json: @link, status: :unprocessable_entity
  rescue StandardError => e
    render json: { errors: e.message }, status: :unprocessable_entity
  end

  def redirect
    @link = find_link(redirect_params).run

    return render json: { message: 'Link not found' }, status: :not_found unless @link

    set_accessed_cookie_identifier

    hit_link

    redirect_to @link.destination_url
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

    def find_link(params)
      Link::Find.new(
        params,
        LinkRepository
      )
    end

    def link_params
      params
        .require(:link)
        .permit(:destination_url)
    end

    def redirect_params
      params
        .permit(:identifier)
    end

    def set_accessed_cookie_identifier
      @accessed_cookie_value = cookies["accessed_cookie_#{@link.id}"]
      set_cookie unless @accessed_cookie_value
    end

    def set_cookie
      @accessed_cookie_value = generate_unique_token(@link.identifier)
      cookies["accessed_cookie_#{@link.id}"] = { :value => @accessed_cookie_value, :expires => Time.now + 1.month}
    end

    def hit_link
      HitCreatePublisher.run(@link.id, @accessed_cookie_value)
    end
end
