# Basic Ruby on Rails: Top Score Ranking

## Goal of excercise

We want to assess if you can:
1. Create a project using our stack
2. Design an API using our requirements
3. Produce clean and easy to review code

## Requirements

In this excercise you will be tasked to design and implement a remote API.

### IMPORTANT!

This API must serve and receive *JSON payloads* and must be designed using *[RESTful API design](https://restfulapi.net/)*.   
This API will be tested using cURL and Postman.

### API Features

This API will be used to keep scores for a certain game for a group of player.
Thus must allow the following actions:

#### Create Score

The client would send a payload containing:
- `player` a String containing the name of player. It will identify the players. "Edo" or "edo" or "EDO" should be the same player. But "Ed0" and "Edo" should not. Do not worry about fuzziness but the name should be case insensitive.
- `score` a Integer strictly superior to 0 that represents the score.
- `time` a String representing date and time. It should be somehow human readable but we let you decide the exact format.

At creation an id must be assigned to a score. The format of the id is up to you to decide.
It is not possible to edit a score once created.

#### Get Score

Using a simple id you can retrieve a score.

#### Delete Score

Using a simple id you can delete a score.

#### Get list of scores

The client can request a list of scores.   
The list can be filtered by date `before` or `after` given times. It can be filtered by `player` names (multiple names can be provided for one query).   
The list must support pagination.

Possible query on this endpoint include (but are not limited to):
- "Get all scores by playerX"
- "Get all score after 1st November 2020"
- "Get all scores by player1, player2 and player3 before 1st december 2020"
- "Get all scores after 1 Jan 2020 and before 1 Jan 2021"

#### Get players' history

The client can request a player history. The resulting payload should contain:
- top score (time and score) which the best ever score of the player.
- low score (time and score) worst score of the player.
- average score value for player
- list of all the scores (time and score) of this player.

We expect Unit Tests/Specs of the components used to deliver this last part.

## Requirements

You must provide integration tests for your API. And unit tests for any logical component.
You do not need to implement logging, authentication or anyother feature. Just worry about the main score feature described above.    

You must provide in a README.md:
1. Instructions on how to build and run your app.
2. Instruction on how to run unit and integration tests.
3. Quick documentation of your API.
4. (bonus/optional) a Docker compose setup that runs you app automatically

Please follow the tools requirements as strictly as possible.

## Tools Requirements

You *MUST* build this system using:
1. Ruby on Rails
2. Any SQL type db is accepted (it is ok if data is lost when app is turned off, this is just an excercise after all).
3. RSpec (tests must be written using this framework)

You may import and use any librairies to your convenience. We value KISS and DRY in our day to day job too.

## What you will be graded on

Here are the things we care most about:
- Ability to design a remote API using RESTful convention. The stricter you obey the conventions the better.
- Ability to follow technical requirements.
- Ability to write complete Unit tests and sufficient Integration tests.
- Ability to deliver features writing the least amount of code possible. We encourage you to leverage the framework as much as possible.
- Quality of writing basic instruction to use/run your code.
- Understanding of K.I.S.S.
- Ability to setup a project to make it easy for other developers to start running, testing and developing.

## Delivery of solution

To deliver:
Create a github, gitlab or bitbucket repository and push your solution there. We will only test and review your master branch. Do not forget the main `README.md` we specify above.    
Send us link to the repo by email.   

You do not need to run or host the app online for us. We will do the testing on our side.