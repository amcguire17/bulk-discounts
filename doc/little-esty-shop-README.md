# Little Esty Shop

## Table of Contents

- [Background and Description](#background-and-description)
- [Learning Goals](#learning-goals)
- [Requirements](#requirements)
- [Setup](#setup)
- [Phases](#phases)
- [Database Schema](#database-schema)
- [Overview](#overview)
- [Learning Goals](#learning-goals)
- [Tools Used](#tools-used)
- [Contributors](#contributors)

## Background and Description

"Little Esty Shop" is a group project that requires students to build a fictitious e-commerce platform where merchants and admins can manage inventory and fulfill customer invoices.

## Learning Goals
- Practice designing a normalized database schema and defining model relationships
- Utilize advanced routing techniques including namespacing to organize and group like functionality together.
- Utilize advanced active record techniques to perform complex database queries
- Practice consuming a public API while utilizing POROs as a way to apply OOP principles to organize code

## Requirements
- must use Rails 5.2.x
- must use PostgreSQL
- all code must be tested via feature tests and model tests, respectively
- must use GitHub branching, team code reviews via GitHub comments, and github projects to track progress on user stories
- must include a thorough README to describe the project
- must deploy completed code to Heroku

## Setup

This project requires Ruby 2.7.2.

* Fork this repository
* Clone your fork
* From the command line, install gems and set up your DB:
    * `bundle`
    * `rails db:create`
* Run the test suite with `bundle exec rspec`.
* Run your development server with `rails s` to see the app in action.


## Phases

1. [Database Setup](./doc/db_setup.md)
1. [User Stories](./doc/user_stories.md)
1. [Extensions](./doc/extensions.md)
1. [Evaluation](./doc/evaluation.md)

## Database Schema
[![Screen-Shot-2021-08-02-at-5-14-18-PM.png](https://i.postimg.cc/BnPWSScM/Screen-Shot-2021-08-02-at-5-14-18-PM.png)](https://postimg.cc/Sn41VpPM)


## Overview

[Little-Esty-Shop](https://github.com/InOmn1aParatus/little-esty-shop) is a week long group project during Mod 2 of Turing School's Back-End Engineering program.

The goal was to create a functioning Rails Application that can take users through a website and give them the ability to use CRUD commands to Create, Read, Update, and Destroy data while being able to veiw the changes on the website(Rails Application).

## Learning Goals

Learning goals and areas of focus consisted of:
- Design multiple Many-to-Many relationships using a schema designer
- Write migrations to create tables with columns of varying data types and foreign keys.
- Use Rails to create web pages that allow users to CRUD resources
- Create instance and class methods on a Rails model that use ActiveRecord methods and helpers
- Write model and feature tests that fully cover data logic and user behavior


## Tools Used

| Development | Testing       | Gems          |
|   :----:    |    :----:     |    :----:     |
| Ruby 2.7.2  | RSpec         | SimpleCov     |
| Rails       |               | Pry           |
| HTML5       |               | Capybara      |
| CSS3        |               | ShouldaMatcher|
| VSCode      |               | Launchy       |
| Atom        |               | Orderly       |
| Github      |               |               |


## Contributors

👤  **Amanda McGuire**
- [GitHub](https://github.com/amcguire17)
- [LinkedIn](https://www.linkedin.com/in/amanda-e-mcguire/)

👤  **Matt Kragen**
- [GitHub](https://github.com/InOmn1aParatus)
- [LinkedIn](https://www.linkedin.com/in/mattkragen/)

👤  **Carina Sweet**
- [GitHub](https://github.com/chsweet)
- [LinkedIn](https://www.linkedin.com/in/carina-h-sweet/)

👤  **Ezzedine Alwafai**
- [GitHub](https://github.com/ealwafai)
- [LinkedIn](https://www.linkedin.com/in/ezzedine-alwafai/)
