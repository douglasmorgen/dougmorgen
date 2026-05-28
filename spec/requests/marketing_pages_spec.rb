require "rails_helper"

RSpec.describe "Marketing pages", type: :request do
  describe "indexable buyer pages" do
    {
      "/" => "SMB Automation, Rails, and Shopify Consultant | Doug Morgen",
      "/services" => "SMB Automation and Software Consulting Services | Doug Morgen",
      "/work" => "Rails, Shopify, and SMB Automation Case Studies | Doug Morgen",
      "/about" => "About Doug Morgen, SMB Automation and Rails Consultant",
      "/faq" => "SMB Automation and Practical Software Help FAQ | Doug Morgen",
      "/contact" => "Talk to Doug Morgen About Automation or Software Work"
    }.each do |path, title|
      it "renders #{path} with SEO metadata and an inquiry form in the first section" do
        get path

        expect(response).to have_http_status(:ok)
        document = Nokogiri::HTML(response.body)

        expect(document.at_css("title").text).to eq(title)
        expect(document.at_css("meta[name='robots']")["content"]).to eq("index,follow,max-image-preview:large")
        expect(document.at_css("main section form")["action"]).to eq("/inquiries")
        expect(response.body).to include("Ask Doug to take a look")
      end
    end
  end

  describe "background pages" do
    [ "/blog", "/resume" ].each do |path|
      it "marks #{path} noindex while keeping the conversion form available" do
        get path

        expect(response).to have_http_status(:ok)
        document = Nokogiri::HTML(response.body)

        expect(document.at_css("meta[name='robots']")["content"]).to eq("noindex,follow")
        expect(document.at_css("main section form")["action"]).to eq("/inquiries")
      end
    end
  end

  it "keeps noindex pages out of the sitemap" do
    sitemap = Rails.root.join("public/sitemap.xml").read

    expect(sitemap).to include("https://dougmorgen.com/services")
    expect(sitemap).to include("https://dougmorgen.com/faq")
    expect(sitemap).not_to include("https://dougmorgen.com/resume")
    expect(sitemap).not_to include("https://dougmorgen.com/blog")
  end
end
