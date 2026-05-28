class Inquiry < ApplicationRecord
  PROJECT_TYPES = [
    "Business process automation",
    "Operations workflow",
    "Rails app",
    "Shopify / e-commerce",
    "Internal tool",
    "API integration",
    "Data import / cleanup",
    "Ongoing technical leadership",
    "Not sure yet"
  ].freeze

  BUDGETS = [
    "Under $5k",
    "$5k–$15k",
    "$15k–$50k",
    "$50k+",
    "Not sure"
  ].freeze

  TIMELINES = [
    "ASAP",
    "This month",
    "1–3 months",
    "Flexible"
  ].freeze

  before_validation :set_defaults

  validates :name, presence: true
  validates :email, presence: true, format: { with: URI::MailTo::EMAIL_REGEXP }
  validates :message, presence: true
  validates :honeypot, absence: true

  private

  def set_defaults
    self.status = "new" if status.blank?
    self.source_page = "/start" if source_page.blank?
  end
end
