class InquiryMailer < ApplicationMailer
  def notification(inquiry)
    @inquiry = inquiry

    mail(
      to: ENV.fetch("INQUIRY_NOTIFICATION_EMAIL", "inquiries@dougmorgen.com"),
      subject: "New inquiry from #{@inquiry.name}"
    )
  end

  def confirmation(inquiry)
    @inquiry = inquiry

    mail(
      to: @inquiry.email,
      subject: "Thanks for your inquiry"
    )
  end
end
