class InquiryMailer < ApplicationMailer
  def notification(inquiry)
    @inquiry = inquiry

    mail(
      to: ENV.fetch("INQUIRY_NOTIFICATION_EMAIL", "inquiries@dougmorgen.com"),
      subject: "New inquiry from #{@inquiry.name}"
    )
  end
end
