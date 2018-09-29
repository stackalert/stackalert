# frozen_string_literal: true

module CheckHelper
  def check_certificate_color(check_certificate)
    if check_certificate.expired?
      'danger'
    else
      'success'
    end
  end

  def check_domain_color(check_domain)
    if check_domain.expired?
      'danger'
    else
      'success'
    end
  end
end
