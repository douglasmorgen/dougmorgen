class PagesController < ApplicationController
  def home
    set_meta(
      title: "I build the software your business actually needs.",
      description: "Rails apps, Shopify systems, internal tools, automations, and data workflows for founders and operators who need useful software shipped fast."
    )
  end

  def services
    set_meta(
      title: "Services",
      description: "Rails, Shopify, workflow automation, API integrations, and pragmatic CTO guidance to help your team ship useful software quickly."
    )
  end

  def work
    set_meta(
      title: "Work",
      description: "Examples of practical software engagements for founders, SMBs, and operations-heavy businesses."
    )
  end

  def about
    set_meta(
      title: "About Doug Morgen",
      description: "Senior software engineer and fractional CTO helping teams build practical systems that drive real operations."
    )
  end

  def blog
    set_meta(
      title: "Blog",
      description: "Notes on Rails delivery, operations software, and pragmatic product execution."
    )
  end

  def resume
    set_meta(
      title: "Resume",
      description: "Doug Morgen's engineering and fractional CTO experience across Rails, e-commerce, and business operations systems."
    )
  end

  def contact
    set_meta(
      title: "Contact",
      description: "Get in touch with Doug Morgen about building or improving your software systems."
    )
  end
end
