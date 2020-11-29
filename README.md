# 📡 Age UK Boost

An app to connect Age UK volunteers to people in need, without accidentally exposing unnecessary personal data.

**Need help setting this app up? [Get in touch with me!](https://twitter.com/dinosaurenby/)**

---

<p align="center">
   <img src="https://github.com/jhackett1/age-uk/raw/master/public/demo.jpg?raw=true" width="650px" />     
</p>
<p align="center">
   <em>Examples of the "explore tasks" feature</em>         
</p>

---

This app was created to help an Age UK branch run their home food delivery service during the coronavirus pandemic.

It offers out tasks, which volunteers can then claim and add to their planner.

Personal information about the person in need is only revealed once a volunteer has claimed a task. Soon after a task is marked as done, it will disappear from the volunteer's planner.

Users log in by **verifying their phone number** using a single-use code - this way it's friendly for volunteers who don't often use email, and for coordinators who may already be organising using WhatsApp groups or similar.

It can work standalone, but works best when tasks are sources from an existing tool, like a Google Sheet or existing CRM.

Here are some [user stories and journeys](https://docs.google.com/presentation/d/e/2PACX-1vT-i_rTxszidM1OKbcOfKe8DoMuGqMiezM2e8CqGwtutLHiRv5cATqwVLxgxYRz0SFHTfR86yLYMwmM/pub?start=false&loop=false&delayms=3000) the app forms a part of.

## 🧱 How it's made

It's a Rails application backed by a PostgreSQL database.

It has a built-in admin dashboard accessible to authorised users, powered by [Administrate](https://github.com/thoughtbot/administrate).

It uses [Twilio](https://www.twilio.com/) to send SMS messages, including to send one-time login codes

It uses [Nominatim](https://nominatim.openstreetmap.org/ui/search.html)'s free geocoding service to convert postcodes into longitude and latitude data. Beware that Nominatim has an [acceptable use policy](https://operations.osmfoundation.org/policies/nominatim/).

## 💻 Running it locally

You need ruby and node.js installed, and a PostgreSQL server running.

First, clone the repo:

```
bundle install
npm install
rails db:setup
rails s
```

It'll be on localhost:3000.

It will populate the database with some fake demo tasks and an admin user.

Make sure you provide the `ADMIN_PHONE` environment variable before running `rails db:setup`.

When developing locally, SMS messages will be logged to the console instead of being sent using Twilio.


## 🌍 Running it on the web

[![Deploy](https://www.herokucdn.com/deploy/button.svg)](
https://heroku.com/deploy)

It's suitable for 12-factor app hosting like [Heroku](http://heroku.com). It's a tiny app, so a $7/month hobby dyno is plenty.

It has a `Procfile` that will [automatically run](https://devcenter.heroku.com/articles/release-phase) pending rails migrations on every deploy, to reduce downtime.

## ⏰ Scheduled tasks

You can run `rails notify_about_new_tasks` on a schedule of your choosing to notify users by SMS about tasks offered in the last day, if they've said they want to recieve those notifications in their profile.

You could use [Heroku Scheduler](https://devcenter.heroku.com/articles/scheduler) or similar for this.

## 🧬 Configuration

| Variable                               | Why?                                                                                                                                                           |
|----------------------------------------|----------------------------------------------------------------------------------------------------------------------------------------------------------------|
| `HOST`                                 | The current publicly-accessible URL of the website, used in some SMS notifications                                                                             |
| `ADMIN_PHONE`                          | For the demo admin user when seeding the database. Only needed when seeding a fresh database.                                                                  |
| `TWILIO_SID`  and  `TWILIO_AUTH_TOKEN` | Can be gained from the [Twilio console](https://support.twilio.com/hc/en-us/articles/223136027-Auth-Tokens-and-How-to-Change-Them). Only needed in production. |
| `TWILIO_FROM_NUMBER`                   | Should be a valid phone number you've claimed on the Twilio console, in the E.164 format.                                                                      |

You can provide environment config locally using a [`.env` file](https://github.com/bkeepers/dotenv).

## 🧪 Roadmap

To do:

1. redesign the tasks#show action to fetch based on `Task.available` or `current_user.tasks`

2. make a background job to remind users about _due_ tasks too

3. write google sheet import script and blank template

4. Limit the number of open tasks a volunteer can claim at once
