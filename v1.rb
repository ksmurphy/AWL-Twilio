### Get twilio-ruby from twilio.com/docs/ruby/install
require 'sinatra'
require 'twilio-ruby'

#new Line

### TO DO ###
## should be able to use * and #, recognized by gather
## Manage time-outs
## Play music
## Add voice recognition?
## Record calls at the point of selection, can we know when the user hung up, at what point?


post '/voice' do
  Twilio::TwiML::VoiceResponse.new do |r|
    r.gather(numDigits: 1, action: '/gather') do |g|
      g.say(message: 'Thank you for calling Affordable Wheelchair Lifts. Your call is important to us 
                      and may be recorded for quality purposes. PLease choose from the folloiwng options.')
      g.say(message: 'Press 1 for sales. Press 2 for Order and Shipping status. Press 3 for Technical 
                      Support and Service. Press 4 for Customer lift pick ups and factory visits. 
                      Press 5 for Billing and Accounting questions. Press 6 to dial by name. Press 7
                      for Company location, hours and other information. Press 8 to repeat this menu.
                      For the operator, press 0.')

    end

# If the user doesn't enter input, loop
#    r.say(message: 'I did not get a response')
    r.redirect('/voice')
  end.to_s
end

# Call a number code for reference
#        r.say(message: 'Transferring to Rich Keller')
#        r.dial(number: '757-876-8991') #, action: )
#        r.redirect('/voice')

post '/gather' do
  if params['Digits']
    case params['Digits']

    when '1' #sales
      Twilio::TwiML::VoiceResponse.new do |r|
        r.gather(slsDigits: 1, action: '/salestree') do |g|
          g.say(message: 'Welcome to the sales menu. Press 1 for next available sales agent. Press 2 for Gale King. Press 3 for 
                          Rich Keller. Press 4 for Shae Murphy. Press 8 to repeat this menu. press 9 to
                          return the main menu. For the operator, press 0.')

        end

# If the user doesn't enter input, loop
      r.redirect('/gather')
      end.to_s
    when '2' #order
      Twilio::TwiML::VoiceResponse.new do |r|
        r.say(message: 'Order.')
        r.pause
        r.redirect('/voice')
      end.to_s      
    when '3' #tech
      Twilio::TwiML::VoiceResponse.new do |r|
        r.say(message: 'Tech')
        r.pause
        r.redirect('/voice')
      end.to_s      
    when '4' #visits
      Twilio::TwiML::VoiceResponse.new do |r|
        r.say(message: 'Visiting us!')
        r.pause
        r.redirect('/voice')
      end.to_s      
    when '5' #billing
      Twilio::TwiML::VoiceResponse.new do |r|
        r.say(message: 'Accounting!')
        r.pause
        r.redirect('/voice')
      end.to_s      
    when '6' #byname, how to grab company information by name?
      Twilio::TwiML::VoiceResponse.new do |r|
        r.say(message: 'Need company directory!')
        r.pause
        r.redirect('/voice')
      end.to_s      
    when '7' #companyinfo
      Twilio::TwiML::VoiceResponse.new do |r|
        r.say(message: 'Thanks again for calling. Our office hours our 8am to 5pm East Coast Standard Time.
                        we can be reached by email, text, or phone.')
        r.pause
        r.redirect('/voice')
      end.to_s      
    when '8' # Return to this menu
      Twilio::TwiML::VoiceResponse.new do |r|
        r.redirect('/voice')
      end.to_s
    when '9' #main menu
      Twilio::TwiML::VoiceResponse.new do |r|
        r.redirect('/voice')
      end.to_s      
    else
      Twilio::TwiML::VoiceResponse.new do |r|
        r.say(message: 'Sorry, I don\'t understand that choice.')
        r.pause
        r.redirect('/voice')
      end.to_s
    end
  else
    Twilio::TwiML::VoiceResponse.new do |r|
      r.redirect('/voice')
    end.to_s
  end
end

post '/salestree' do
  if params['Digits']
    case params['Digits']

    when '1' # Available sales agent (how to round robin to check availability?)
      Twilio::TwiML::VoiceResponse.new do |t|
          t.say(message: 'Around the world we go')
          t.pause
      t.redirect('/gather')
      end.to_s
    when '2' # Gale King
      Twilio::TwiML::VoiceResponse.new do |t|
          t.say(message: 'Transferring to Gale King')
          t.pause
#          t.dial(number: '') #, action: )
          t.redirect('/gather')
      end.to_s
    when '3' # Rich Keller
      Twilio::TwiML::VoiceResponse.new do |t|
          t.say(message: 'Transferring to Rich Keller')
          t.pause
#          t.dial(number: '434-277-2322') #, action: )  # Rich's Twilio number
          t.redirect('/gather')
      end.to_s
    when '4' # Shae Murphy
      Twilio::TwiML::VoiceResponse.new do |t|
          t.say(message: 'Transferring to Shae Murphy')
          t.pause
#          t.dial(number: '757-784-7197') #, action: )
          t.redirect('/gather')
      end.to_s
    when '8' # Repeat menu
      Twilio::TwiML::VoiceResponse.new do |t|
        t.say(message: 'Repeating this menu')
        t.pause
        t.redirect('/gather')
      end.to_s
    when '9' # Main menu
      Twilio::TwiML::VoiceResponse.new do |t|
        t.say(message: 'Going to main menu')
        t.pause
        t.redirect('/voice')
      end.to_s
    when '0' # Operator
      Twilio::TwiML::VoiceResponse.new do |t|
        t.say(message: 'Trasnferring to operator')
        t.pause
      end.to_s
    end
  else
    Twilio::TwiML::VoiceResponse.new do |t|
      t.say(message: 'I did not understand your input.')
      t.pause
      t.redirect('/gather')
    end.to_s
  end
end