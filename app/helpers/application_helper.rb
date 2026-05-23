module ApplicationHelper
  LINKEDIN_URL = "https://www.linkedin.com/in/dougmorgen/".freeze

  def meta_title
    content_for(:meta_title).presence || @meta_title.presence || "Doug Morgen | Fractional CTO and Senior Rails Engineer"
  end

  def meta_description
    content_for(:meta_description).presence || @meta_description.presence || "Doug Morgen is a fractional CTO and senior software engineer building Rails apps, Shopify systems, internal tools, automations, API integrations, dashboards, and data workflows."
  end

  def canonical_url
    path = request.path == "/" ? "" : request.path
    "https://dougmorgen.com#{path}"
  end

  def og_image_url
    "https://dougmorgen.com/og-image.jpg?v=20260522b"
  end

  def og_image_alt
    "Doug Morgen, Fractional CTO and Senior Rails Engineer"
  end

  def person_structured_data_json
    {
      "@context" => "https://schema.org",
      "@type" => "Person",
      name: "Doug Morgen",
      url: "https://dougmorgen.com",
      sameAs: [ linkedin_url ],
      jobTitle: "Fractional CTO and Senior Software Engineer",
      description: "Fractional CTO, half-time CTO, and Rails consultant for founders, SMBs, e-commerce companies, and operations-heavy teams.",
      knowsAbout: [
        "Ruby on Rails",
        "Shopify",
        "E-commerce systems",
        "Internal tools",
        "Workflow automation",
        "API integrations",
        "Data imports and cleanup",
        "Dashboards",
        "Accounting migrations"
      ]
    }.to_json
  end

  def linkedin_url
    LINKEDIN_URL
  end

  def nav_link_to(label, path)
    base = "rounded-full px-4 py-2 text-sm font-semibold transition"
    active = current_page?(path) ? "bg-blue-600 text-white" : "text-slate-700 hover:bg-slate-200"

    link_to label, path, class: "#{base} #{active}"
  end
end
