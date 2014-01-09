require 'rubygems'
require 'nokogiri'
require 'restclient'
require 'cinch'

bot = Cinch::Bot.new do
  configure do |c|
    c.server = "irc.freenode.org"
    c.nick     = "MrWaffleMoon"
    c.channels = ["#hackerhang"]
  end

  #on :message, "hello" do |m|
  #  m.reply "Hello, #{m.user.nick}"
  #end

  on :message, ".mining" do |m|

  	mining = Nokogiri::HTML(RestClient.post 'https://www.multipool.us', {:params => {'foo' => 'bar'}})
	mine = mining.css("#multiport-table tbody tr td .med")

  	m.reply "Hey #{m.user.nick} We are mining scrypt: #{mine[0].text.upcase} and sha-256: #{mine[1].text.upcase}"
  end
end

bot.start