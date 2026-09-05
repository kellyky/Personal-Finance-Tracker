module Authentication
  extend ActiveSupport::Concern

  included do
    before_action :require_authentication
  end

  class_methods do
    def allow_unauthenticated_access(**options)
      skip_before_action :require_authentication, **options
    end
  end

  private

  def authenticated?
    resume_session
  end

  def require_authentication
    resume_session || render_unauthorized
  end

  def render_unauthorized
    render json: { error: 'Unauthorized' }, status: :unauthorized
  end

  def after_authentication_url
    session.delete(:return_to_after_authenticating) || root_url
  end

  def start_new_session_for(user)
    user_agent = request.user_agent
    ip_address = request.remote_ip

    user.sessions.create!(user_agent:, ip_address:).tap do |session|
      Current.session = session
    end
  end

  def terminate_session
    Current.session.destroy
  end

  def resume_session
    Current.session = find_session_by_token
  end

  def find_session_by_token
    token = request.headers[:Authorization]&.split(' ')[-1]
    Session.find_by(token:)
  end
end
