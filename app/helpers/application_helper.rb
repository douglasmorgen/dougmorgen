module ApplicationHelper
  LINKEDIN_URL = "https://www.linkedin.com/in/dougmorgen/".freeze

  def meta_title
    content_for(:meta_title).presence || @meta_title.presence || "Doug Morgen | SMB Automation and Rails Consultant"
  end

  def meta_description
    content_for(:meta_description).presence || @meta_description.presence || "Doug Morgen helps SMBs, founders, and e-commerce operators automate workflows, build Rails and Shopify systems, connect APIs, and streamline operations with practical software."
  end

  def meta_robots
    content_for(:meta_robots).presence || "index,follow,max-image-preview:large"
  end

  def canonical_url
    path = request.path == "/" ? "" : request.path
    "https://dougmorgen.com#{path}"
  end

  def og_image_url
    "https://dougmorgen.com/og-image.jpg?v=20260522b"
  end

  def og_image_alt
    "Doug Morgen, SMB automation consultant and senior Rails engineer"
  end

  def person_structured_data_json
    {
      "@context" => "https://schema.org",
      "@type" => "Person",
      name: "Doug Morgen",
      url: "https://dougmorgen.com",
      sameAs: [ linkedin_url ],
      jobTitle: "SMB Automation Consultant and Senior Rails Engineer",
      description: "Software consultant, automation partner, senior Rails engineer, and ongoing technical partner for SMBs, founders, e-commerce companies, and operations-heavy teams.",
      knowsAbout: [
        "Business process automation",
        "SMB operations software",
        "Ruby on Rails",
        "Shopify",
        "E-commerce systems",
        "Internal tools",
        "Workflow automation",
        "API integrations",
        "Data imports and cleanup",
        "Dashboards",
        "Accounting migrations",
        "Ongoing technical leadership"
      ]
    }.to_json
  end

  def linkedin_url
    LINKEDIN_URL
  end

  def inquiry_form_timing_values
    started_at = Time.current.to_i
    signature = Rails.application.message_verifier(:inquiry_form).generate(started_at, purpose: :inquiry_form_timing)

    [ started_at, signature ]
  end

  def nav_link_to(label, path)
    base = "rounded-full px-4 py-2 text-sm font-semibold transition"
    active = current_page?(path) ? "bg-blue-600 text-white" : "text-slate-700 hover:bg-slate-200"

    link_to label, path, class: "#{base} #{active}"
  end
end
