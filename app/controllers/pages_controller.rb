class PagesController < ApplicationController
  def home
    set_meta(
      title: "SMB Automation, Rails, and Shopify Consultant | Doug Morgen",
      description: "Doug Morgen helps SMBs, founders, and e-commerce operators automate workflows, build Rails and Shopify systems, connect APIs, and replace manual operations."
    )
  end

  def services
    set_meta(
      title: "SMB Automation and Software Consulting Services | Doug Morgen",
      description: "Automation consulting, Rails applications, Shopify systems, internal tools, API integrations, data cleanup, and ongoing technical partnership for SMBs."
    )
  end

  def work
    set_meta(
      title: "Rails, Shopify, and SMB Automation Case Studies | Doug Morgen",
      description: "Selected software consulting work across SMB automation, Rails apps, Shopify systems, internal tools, accounting migrations, and operations workflows."
    )
  end

  def about
    set_meta(
      title: "About Doug Morgen, SMB Automation and Rails Consultant",
      description: "Doug Morgen helps SMBs, founders, and e-commerce teams build practical software, automate operations, connect systems, and ship Rails and Shopify work."
    )
  end

  def blog
    set_meta(
      title: "Doug Morgen Notes on SMB Automation, Rails, and Shopify",
      description: "Notes from Doug Morgen on SMB automation, Rails delivery, Shopify operations, workflow software, and practical product execution."
    )
  end

  def resume
    set_meta(
      title: "Doug Morgen Background | SMB Automation and Rails Engineer",
      description: "Background for Doug Morgen: SMB automation, senior Rails engineering, Shopify systems, accounting migrations, e-commerce operations, and software delivery."
    )
  end

  def contact
    set_meta(
      title: "Talk to Doug Morgen About Automation or Software Work",
      description: "Contact Doug Morgen for SMB automation, Rails consulting, Shopify systems, internal tools, API integrations, data workflows, and practical technical leadership."
    )
  end
end
