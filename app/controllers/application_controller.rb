class ApplicationController < ActionController::Base
    before_action :configure_permitted_parameters, if: :devise_controller?
    before_action :set_search

    def after_sign_in_path_for(resource)
        posts_path
    end
    
    private

    def sign_in_required
      redirect_to new_user_session_url unless user_signed_in?
    end

    def configure_permitted_parameters
      added_attrs = [ :email, :username, :password, :password_confirmation ]
      devise_parameter_sanitizer.permit :sign_up, keys: added_attrs
      devise_parameter_sanitizer.permit :account_update, keys: [added_attrs, :profile, :icon_image]
      devise_parameter_sanitizer.permit :sign_in, keys: added_attrs
    end

    def set_search
      @search = Post.ransack(params[:q])
      @search_data = @search.result.order(created_at: :desc)
      @search_posts = Kaminari.paginate_array(@search_data).page(params[:page]).per(10)
    end
end
