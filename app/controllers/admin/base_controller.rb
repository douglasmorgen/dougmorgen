require "digest"

class Admin::BaseController < ApplicationController
  before_action :authenticate_admin!

  private

  def authenticate_admin!
    username = ENV["ADMIN_USERNAME"].to_s
    password = ENV["ADMIN_PASSWORD"].to_s

    authenticate_or_request_with_http_basic("Admin") do |provided_username, provided_password|
      secure_compare(provided_username, username) && secure_compare(provided_password, password)
    end
  end

  def secure_compare(a, b)
    return false if a.blank? || b.blank?

    ActiveSupport::SecurityUtils.secure_compare(
      ::Digest::SHA256.hexdigest(a),
      ::Digest::SHA256.hexdigest(b)
    )
  end
end
