# Basic Ruby on Rails: Top Score Ranking

This README would normally document whatever steps are necessary to get the
application up and running. Things you may want to cover:

 Languages | Version
------------ | -------------
![image](https://raw.githubusercontent.com/Shahidrox/icone/main/Ruby.svg) | ruby `'3.0.1'`
![image](https://raw.githubusercontent.com/Shahidrox/icone/main/Ruby_on_Rails.svg) |  rails `'6.1.4.1'`
![image](https://raw.githubusercontent.com/Shahidrox/icone/main/PostgreSQL.svg) | (PostgreSQL) `'13.3'`
![image](https://raw.githubusercontent.com/Shahidrox/icone/main/Node.svg) | node (-> `'v14.17.1'`)
![image](https://raw.githubusercontent.com/Shahidrox/icone/main/Docker.svg) | Docker `'20.10.7'`
<img src ="https://raw.githubusercontent.com/Shahidrox/ImageIcone/main/mac.png" width="40"> | Big Sur `'11.4 (20F71)'`

## Getting Started
```bash
git clone https://github.com/Shahidrox
cd docker_rails_api
```
```bash
bundle exec rails db:create -e test
bundle exec rails db:migrate -e test
bundle exec rspec
File: TopScoreRanking/spec/requests/api/v1/score_spec.rb
```
 Docker | - setup
------------ | -------------
**Image rebuild:** | ```$ docker-compose build```
**Container launch:** | ```$ docker-compose up -d```
**DB create:** | ```$ docker-compose run web rails db:create```
**DB migrate:** | ```$ docker-compose run web rails db:migrate```
**Test:** |```$ curl 0.0.0.0:3000```
**CONTAINER LIST:** | ```$ docker container ls```
**CONTAINER STOP:** | ```$ docker stop <container-name>```
**Removing All Unused Docker Objects:** | ```$ docker system prune```

## API Document 
**Swagger Doc**|-
------------|--------------
http://localhost:3000/api-docs/v1/index.html | ![image](https://raw.githubusercontent.com/Shahidrox/icone/main/swagger-ui.png)
## API
Type|method|API | Params
-|-|-|-
Create Score|<img src="https://raw.githubusercontent.com/Shahidrox/icone/main/post.png" width="50" height="20">|```/api/v1/scores)```|```{ player: name, score: 11, time: 2021-09-04T08:07:13.161Z }```
Get Score|<img src="https://raw.githubusercontent.com/Shahidrox/icone/main/get.png" width="50" height="20">|```/api/v1/scores/{id}```|```-```
Delete Score| <img src="https://raw.githubusercontent.com/Shahidrox/icone/main/delete.png" width="50" height="20">|```/api/v1/scores/{id}```|```-```
Get all scores by playerX|<img src="https://raw.githubusercontent.com/Shahidrox/icone/main/get.png" width="50" height="20">|```/api/v1/scores```|```{ player: playerX }```
Get all score after 1st November 2020|<img src="https://raw.githubusercontent.com/Shahidrox/icone/main/get.png" width="50" height="20">|```/api/v1/scores```|```{ after: 1st November 2020 }```
Get all score before 1st December 2020|<img src="https://raw.githubusercontent.com/Shahidrox/icone/main/get.png" width="50" height="20">|```/api/v1/scores```|```{ before: 1st December 2020}```
Get all scores by playerX, playerY before 1st december 2020|<img src="https://raw.githubusercontent.com/Shahidrox/icone/main/get.png" width="50" height="20">|```/api/v1/scores```|```{ player: playerX, playerY, before: 1st December 2020}```
Get all scores after 1 Jan 2020 and before 1 Jan 2021|<img src="https://raw.githubusercontent.com/Shahidrox/icone/main/get.png" width="50" height="20">|```/api/v1/scores```|```{ before: '1 Jan 2021', after: '1 Jan 2020' }```
Get all scores by playerX after 1 Jan 2020 and before 1 Jan 2021|<img src="https://raw.githubusercontent.com/Shahidrox/icone/main/get.png" width="50" height="20">|```/api/v1/scores```|```{ player: playerY, before: 1 Jan 2021, after: 1 Jan 2020 }```
list of top score|<img src="https://raw.githubusercontent.com/Shahidrox/icone/main/get.png" width="50" height="20">|```/api/v1//scores/playerscorehistory/{playerX}/Top```|```-```
list of low score|<img src="https://raw.githubusercontent.com/Shahidrox/icone/main/get.png" width="50" height="20">|```/api/v1//scores/playerscorehistory/{playerX}/Low```|```-```
list of average score|<img src="https://raw.githubusercontent.com/Shahidrox/icone/main/get.png" width="50" height="20">|```/api/v1//scores/playerscorehistory/{playerX}/Average```|```-```
list of all the scores of this player|<img src="https://raw.githubusercontent.com/Shahidrox/icone/main/get.png" width="50" height="20">|```/api/v1//scores/playerscorehistory/{playerX}/All```|```-```