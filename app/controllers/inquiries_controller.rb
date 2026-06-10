class InquiriesController < ApplicationController
  MIN_SUBMISSION_SECONDS = 3
  MAX_SUBMISSION_AGE = 1.day

  rate_limit to: 5,
             within: 10.minutes,
             by: -> { request.remote_ip },
             only: :create,
             with: -> { render_rate_limit_error }

  def new
    @inquiry = Inquiry.new(source_page: request.path)
    set_meta(
      title: "Ask Doug Morgen About Automation or Software Work",
      description: "Tell Doug Morgen what you want to build, automate, or fix and get next steps."
    )
    set_form_protection_values
  end

  def create
    @inquiry = Inquiry.new(inquiry_params)

    if submission_timing_invalid?
      @inquiry.errors.add(:base, "Please wait a few seconds and try again.")
      render_inquiry_form_error(status: :unprocessable_content)
    elsif @inquiry.save
      InquiryMailer.notification(@inquiry).deliver_now
      InquiryMailer.confirmation(@inquiry).deliver_now
      redirect_to inquiry_thank_you_path
    else
      render_inquiry_form_error(status: :unprocessable_content)
    end
  end

  def thank_you
    set_meta(
      title: "Thanks for reaching out to Doug Morgen",
      description: "Your message was sent to Doug Morgen."
    )
  end

  private

  def inquiry_params
    params.expect(inquiry: [
      :name,
      :email,
      :company,
      :phone,
      :project_type,
      :budget,
      :timeline,
      :message,
      :source_page,
      :honeypot
    ])
  end

  def render_rate_limit_error
    @inquiry = Inquiry.new(source_page: "/start")
    @inquiry.errors.add(:base, "Too many attempts. Please wait a minute and try again.")
    render_inquiry_form_error(status: :too_many_requests)
  end

  def render_inquiry_form_error(status:)
    set_meta(
      title: "Ask Doug Morgen About Automation or Software Work",
      description: "Tell Doug Morgen what you want to build, automate, or fix and get next steps."
    )
    set_form_protection_values
    render :new, status: status
  end

  def set_form_protection_values
    @form_started_at = Time.current.to_i
    @form_signature = inquiry_form_verifier.generate(@form_started_at, purpose: :inquiry_form_timing)
  end

  def inquiry_form_verifier
    Rails.application.message_verifier(:inquiry_form)
  end

  def submission_timing_invalid?
    started_at = inquiry_form_verifier.verified(params[:form_signature], purpose: :inquiry_form_timing)
    submitted_started_at = params[:form_started_at].to_i
    return true if started_at.blank? || submitted_started_at <= 0
    return true if started_at.to_i != submitted_started_at

    age = Time.current.to_i - submitted_started_at
    age < MIN_SUBMISSION_SECONDS || age > MAX_SUBMISSION_AGE
  end
end
