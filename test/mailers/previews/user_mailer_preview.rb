# frozen_string_literal: true

# Preview all emails at http://localhost:3000/rails/mailers/user_mailer
class UserMailerPreview < ActionMailer::Preview
  def welcome
    UserMailer.with(user: User.first).welcome
  end

  def confirmation_instructions
    UserMailer.with(user: User.first, token: 'token').confirmation_instructions
  end
end
