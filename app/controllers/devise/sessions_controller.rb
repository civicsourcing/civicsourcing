module Devise
  class SessionsController < DeviseController
    prepend_before_filter :require_no_authentication, :only => [ :new, :create ]
    prepend_before_filter :allow_params_authentication!, :only => :create
    prepend_before_filter { request.env["devise.skip_timeout"] = true }

    # GET /resource/sign_in
    def new
      self.resource = resource_class.new(sign_in_params)
      clean_up_passwords(resource)
      respond_with resource, serialize_options(resource)
    end

    # POST /resource/sign_in
    def create
      return missing_params unless params[:email] && params[:password]
      resource = resource_from_credentials
      return invalid_credentials unless resource
      resource.ensure_authentication_token
      data = {
        user_id: resource.id,
        auth_token: resource.authentication_token,
        auth_email: resource.email,
        card_registered: resource.card_registered?,
        bank_registered: resource.bank_registered?
      }
      render json: data, status: 201
    end

    # DELETE /resource/sign_out
    def destroy
      return missing_params unless params[:auth_token]

      resource = resource_class.find_by_authentication_token(params[:auth_token])
      return invalid_credentials unless resource

      resource.reset_authentication_token!
      render json: {user_id: resource.id}, status: 200
    end

    protected

    def missing_params
      warden.custom_failure!
      return render json: {error: t("devise.failure.missing_params")}, status: 400
    end

    def invalid_credentials
      warden.custom_failure!
      render json: {error: t("devise.failure.invalid")}, status: 401
    end

    def resource_from_auth_token
      User.find_by(authentication_token: params[:auth_token])
    end

    def resource_from_credentials
      data = {email: params[:email] }
      if res = resource_class.find_for_database_authentication(data)
        if res.valid_password?(params[:password])
          res
        end
      end
    end

    def sign_in_params
      devise_parameter_sanitizer.sanitize(:sign_in)
    end

    def serialize_options(resource)
      methods = resource_class.authentication_keys.dup
      methods = methods.keys if methods.is_a?(Hash)
      methods << :password if resource.respond_to?(:password)
      { :methods => methods, :only => [:password] }
    end

    def auth_options
      { :scope => resource_name, :recall => "#{controller_path}#new" }
    end
  end
end