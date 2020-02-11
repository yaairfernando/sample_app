require "rails_helper"

RSpec.describe UserMailer, type: :mailer do
  describe "account_activation" do
    let(:user) { create(:user_activated)}
    it "renders the headers" do
      user = create(:user)
      user.activation_token = User.new_token
      mailer = UserMailer.account_activation(user)
      expect(mailer.subject).to eq("Account activation")
      # expect(mailer.to).to eq(user.email)
      expect(mailer.from).to eq(["noreply@example.com"])
      expect(mailer.body.encoded).to match(user.name)
      expect(mailer.body.encoded).to match(user.activation_token)
      # expect(CGI.escape(user.email)).to eq(mailer.body.encoded)
      expect(mailer.body.encoded).to match("Hi")
    end
  end

  describe "password_reset" do
    let(:mail) { UserMailer.password_reset }

    it "renders the headers" do
      expect(mail.subject).to eq("Password reset")
      expect(mail.to).to eq(["to@example.org"])
      expect(mail.from).to eq(["noreply@example.com"])
    end

    it "renders the body" do
      expect(mail.body.encoded).to match("Hi")
    end
  end

end
