require "rails_helper"

RSpec.describe "Marketing pages", type: :request do
  describe "indexable buyer pages" do
    it "renders the homepage with SEO metadata, nav home link, and the inquiry form" do
      get "/"

      expect(response).to have_http_status(:ok)
      document = Nokogiri::HTML(response.body)

      expect(document.at_css("title").text).to eq("SMB Automation, Rails, and Shopify Consultant | Doug Morgen")
      expect(document.at_css("meta[name='robots']")["content"]).to eq("index,follow,max-image-preview:large")
      expect(document.at_css("nav").text).to include("Home")
      expect(document.at_css("nav a[href='/resume']").text).to eq("Resume")
      expect(document.at_css("main section form")["action"]).to eq("/inquiries")
      expect(document.at_css("#quick-fit-check form")["action"]).to eq("/inquiries")
    end

    {
      "/" => "SMB Automation, Rails, and Shopify Consultant | Doug Morgen",
      "/services" => "SMB Automation and Software Consulting Services | Doug Morgen",
      "/work" => "Rails, Shopify, and SMB Automation Case Studies | Doug Morgen",
      "/about" => "About Doug Morgen, SMB Automation and Rails Consultant",
      "/faq" => "SMB Automation and Practical Software Help FAQ | Doug Morgen",
      "/resume" => "Doug Morgen Resume | CTO and Senior Full-Stack Engineer",
      "/contact" => "Talk to Doug Morgen About Automation or Software Work"
    }.except("/").each do |path, title|
      it "renders #{path} with SEO metadata" do
        get path

        expect(response).to have_http_status(:ok)
        document = Nokogiri::HTML(response.body)

        expect(document.at_css("title").text).to eq(title)
        expect(document.at_css("meta[name='robots']")["content"]).to eq("index,follow,max-image-preview:large")
        expect(document.at_css("main section form")).to be_nil

        unless path == "/resume"
          expect(document.at_css("main section a[href='/start']").text).to include("Get started")
          expect(response.body).to include("Get started")
        end
      end
    end

    it "renders the resume page with a downloadable PDF resume" do
      get "/resume"

      expect(response).to have_http_status(:ok)
      document = Nokogiri::HTML(response.body)
      download_link = document.at_css("main a[href='/doug-morgen-resume.pdf'][download='doug-morgen-resume.pdf']")

      expect(download_link.text).to include("Download resume")
      expect(response.body).to include("CTO · Homebrand")
      expect(response.body).to include("April 2025 - January 2026")
      expect(response.body).to include("B.S. Engineering Science")
      expect(response.body).not_to include("douglasmorgen@gmail.com")
      expect(response.body).not_to include("mailto:")
      expect(response.body).not_to include("(858) 405-1202")
      expect(response.body).not_to include("tel:")
      expect(Rails.root.join("public/doug-morgen-resume.pdf")).to exist
    end
  end

  describe "background pages" do
    [ "/blog" ].each do |path|
      it "marks #{path} noindex while linking to the full form" do
        get path

        expect(response).to have_http_status(:ok)
        document = Nokogiri::HTML(response.body)

        expect(document.at_css("meta[name='robots']")["content"]).to eq("noindex,follow")
        expect(document.at_css("main section form")).to be_nil
        expect(document.at_css("main section a[href='/start']").text).to include("Get started")
      end
    end
  end

  it "keeps noindex pages out of the sitemap" do
    sitemap = Rails.root.join("public/sitemap.xml").read

    expect(sitemap).to include("https://dougmorgen.com/services")
    expect(sitemap).to include("https://dougmorgen.com/faq")
    expect(sitemap).to include("https://dougmorgen.com/resume")
    expect(sitemap).not_to include("https://dougmorgen.com/blog")
  end
end
