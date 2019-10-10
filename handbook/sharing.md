# Better sharing and collaboration

## Google Calendar

Google Calendar is an essential tool for planning time, thus for allowing people to schedule calls and meet each other.

### Allow access to your calendar

Go to `Settings` and click on your calendar:

![My calendar settings](sharing/cal/cal-settings.png)

Make sure, that you have allowed other in the company to see your events:

![My calendar access](sharing/cal/cal-access.png)

### Allow guest to modify invites

Please make sure, that you have set `Default guest permission` under `Settings -> General -> Event settings` to `Modify event` (or at least to `Invite others`).

![Guests can modify events](sharing/cal/modify.png)

This setting will allow your guests to add other people to meetings, add dial-in details, extend description etc.

### Speedy meetings

We suggest using `Speedy meetings` also under `Settings -> General -> Event settings`.

![Speedy meetings](sharing/cal/speedy.png)

That shortens up meetings a bit -- end 30 minute meetings 5 minutes early and longer meetings 10 minutes early. That will allow people to have consecutive meetings scheduled (have you ever came late to meeting because you need to go to the bathroom?).

### Working hours

Set your working hours to give hint to the others, when they should be scheduling meetings with you.

### World clock

Google Calendar has built in simple world clock. I find it quite useful for making a quick decision if I am going to reach out to someone or send an email. You can set it as follows

![World clock settings](sharing/cal/worldclock-settings.png).

That will result into

![World clock rendered](sharing/cal/worldclock.png).

### Holidays in different countries

You may have spotted an automatic calendar tracking holidays in your home country. It looks like this for me:

![Czech Republic Holidays](sharing/cal/holidays1.png)

You can easily add other countries. For example if you want to add Kenyan, you just need to `+ -> Browse calendars of interest -> Regional holidays -> Kenya` as shown below.

![Adding Kenyan holidays](sharing/cal/holidays.gif)

## Donut Calls

We have established a regular weekly [donut](https://www.donut.com/pairing/) calls. These calls about meeting different people in the organization. Learning about them, their lives, family, hobbies. But also chatting about what they do in the organization. Frequently, you will find out, that you can easily help with somebody with something what they consider tedious. If you are software engineer, some simple automation can do a lot for person in finance.

Please, please, please, attend them. Be on time and spend the call chatting.

### How to snooze pairing

Pairing is happening on weekly basis. Sometimes you need to skip the cycle (for example your are going to have vacation). You have two options.

#### Snooze pairing

Got to Slack and find the pairing bot. Its name is `@donut` (for example, you can hit `Ctrl-K` and type `donut`). Send it message `help`. It will present you with option to snooze pairing in return. The whole session may look like the following picture.

![Snooze donut pairing](sharing/pairing.png)

You can choose for how long you want to snooze pairing from the drop-down.

#### (Semi-)Permanently disabling pairing

Other option is simply to leave the pairing channel. Simple leave channel `#donuts`, that will stop you from being considered for donut calls. You can return any time you want.

Please, remember to join back as we will be missing you otherwise!

## Slack

We are using Slack for semi real-time, simple communication. That means, that

- Nobody is required to response on Slack. Slack is treated as strictly **best-effort** communication platform. Only exception being `#mission_control` channel for critical operational issues.
- People will probably overlook messages in channels, when they get back from vacation.
- Please, don't sent messages, which really should go via email:

  - you don't require "immediate" response.
  - person on the other side, will either need to put effort into understanding your question/comment and/or she will need to put effort into responding. Basically, if you are writing something what is longer than 3 sentences, that should probably go to email or ticket.

- We tend to use Slack as a type of "social network". There are channels for casual conversations, sharing interesting links etc.

### Working hours at Slack

It is frequently convenient to mention somebody (those `@antonin.kral`). That will mark particular message and typically trigger more aggressive notification being sent to person. Frequently, one don't need to send the notification straight away. E.g. I am mentioning somebody who is already out of the office (maybe she is in different office, or maybe I am working over-time). I don't want her to respond immediately, but I want to mark the message for her...

It is **your** responsibility to set up working hours. You should do two things:

1. check your home timezone at https://dtoneworkspace.slack.com/account/settings . Mine looks like this ![Slack TZ](sharing/slack/tz.png)
1. open [user profile](https://app.slack.com/client/user_profile/). Click on "more options" (tree dots) and select `View prefereces`. You will be able to find `Do not Disturb` settings under `Notifications`. Mine looks like this ![Slack DND](sharing/slack/dnd.png)
