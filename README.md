Healthify Engineer Coding Challenge
=============================================

Hello there! We're excited to have you try out our code challenge. This challenge is based on some
problems we've faced in real-life at Healthify, so it should give you a good introduction into Healthify's
domain and problem space. Below, you'll find information on the context of this challenge, the tasks we'd like
you to complete, and instructions for setting up this repo.

While completing this challenge, please be mindful of a few of our practices:

* We have a guide for styles and conventions, forked from thoughtbot's, that we adhere to. Please keep these in mind 
when contributing to this repo. https://github.com/healthify/guides
* Everything we do is tested. We have included some tests in this repo and expect your contributions to be tested 
as well. Also, if you think we're missing any tests, please add them!
* We have included some guidelines below for how we will evaluate this assignment so that you know what we're 
expecting.

## Context
One of Healthify's main products is a platform that enables our users (primarily social workers)
to search for Organizations – homeless shelters, food pantries,
substance abuse clinics – for their patients. In this coding challenge, we've built
a minimal version of that platform; the app currently provides a (nonsearchable)
listing of Organizations as well as a few pages to provide CRUD functionality.

The Organizations do not serve all segments of the population; some are only for women,
some only for men, some only for children, some only for HIV positive persons, etc.
We would like our app to reflect this eligibility property of Organizations.

## Tasks

1. Implement functionality to permit filtering our list of Organizations by eligibility.
We want to have a bank of eligibilities, for example `{"Youth", "Seniors", "Ex-Offenders",
"Refugees", "Veterans"}`, and on the page listing our Organizations, we want to be able to
check off eligibilities and then filter the Organizations so that they're limited to only those Organizations 
that offer services for the checked eligibilities. So if we check off "Children" and "Abuse Survivors" and then 
filter, we want to only see Organizations that offer services for "Children", "Abuse Survivors", or both. 
See the mockup provided in `index-mockup.png` for reference.

2. Our current description of the eligibility filtering ("if we check off 'Youth' and 'Refugees' 
and then filter, we want to only see resource sites that offer services for 'Youth', 'Refugees', or both."), 
may be described as an *OR* filtering. This is the more common use case, but there are some users that may want 
an *AND* filter -- a filter that would match only those Organizations for *both* "Youth" and
"Refugees", but not those Organizations for one but not the other. Leave the *OR* filtering
as the default, but implement functionality such that a user may toggle the filtering style to
switch to *AND* filtering. Be mindful of implementing this in the UI such that an average user (who
may have never heard of this AND/OR distinction) will be able to understand what the toggling means.

3. We often need to be able to export lists of organizations to data processing services or clients. Create 
a rake task that generates a CSV of Organizations (and all of their attributes), with the option to use an
 argument passed to the rake task to filter the list of organizations included in the CSV by 
 a single eligibility. Think about what objects you need to achieve this, 
and what objects you may want to reuse from other parts of the codebase to accomplish this filtering.

4. We want to make this app presentable to users. Please write semantic HTML and CSS to make the index page match `index-mockup.png`. Afterwards, improve the UI of the organizations show page using the styles you've created for the index page – you have more autonomy here, and we're simply looking for consistency with the index page's UI. Please reference "Mockup Details" below for more information.

## Mockup Details
For this part of the challenge, we want to see your ability to accurately reproduce details from a mockup, 
infer how other views should look based on the provided mockup, and degrade the UI to mobile without explicit mockups 
for mobile. You can use your best judgement for any aspect of the mockup not shown – hover states and responsive 
mobile views come to mind.

#### Fonts
The only font used is San Fransisco with various weights. Please use this font and specify any other native fallback 
fonts that you think are appropriate.

## Dev Setup
Complete the following to get the existing application up and running.

1. `git clone` down this repository.
2. Install dependencies and setup DB by running the setup script: `bin/setup`.
3. Start the local server: `bundle exec rails server`.
4. Visit 'localhost:3000' in your web browser of choice.

## Tests
This codebase comes with some rspec tests for the existing functionality. Be sure to include tests with your work, 
and feel free to add any tests you think we're missing.

Execute `rake spec` to run the unit test suite.

## Other Things To Consider
1. `git` history: A consistent and accurate git history greatly aids in the code review process - 
which is core to Healthify's technical workflow.

2. Clarity & Documentation: Your code should be expressive and understandable. Solid unit tests usually 
provide enough documentation, but aren't always sufficient. Whether via unit tests, comments, exceptionally 
expressive code or all of the above, make sure you submit easy to understand code!

3. Questions/Concerns/Roadblocks: While we've attempted to minimize unclear requirements, there's the 
possibility that you might have a question about the desirable behavior for some functionality. Where possible, 
please make and document in the Git history any product assumptions you made. We won't count any "incorrect" 
product assumptions against you as long as they are well communicated.

## How this challenge will be evaluated

1. **Did the candidate meet all the basic requirements?** Does the most essential functionality
(filtering by eligibilities and the rake task) work completely and is it tested? Does the UI match the provided mockup?

2. **Did the candidate meet the basic requirements with excellent work?** How
well-factored, clean, readable, DRY, and performant is the code? Is the business logic in the appropriate
places (e.g. models, views, controllers, service objects, helpers, javscripts, stylesheets, etc.)? Are the tests
excellent (clean, readable, etc.) or merely decent? Is the UI responsive?

Please note that for moving candidates forward in our process, we're looking for both 1 and 2 here.
