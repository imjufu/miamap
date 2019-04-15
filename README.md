# Miamap

## Environnement de développement

### Prérequis

* Ruby >= 2.5
  * Gems : bundler
* Docker >= 17.0

### Installation

```
$ git clone git@github.com:imjufu/miamap.git
$ cd miamap
$ bundle
```

### Démarrer l'environnement

```
$ docker-compose up -d

# La première fois, il faut initialiser la base de données
$ bundle exec rake db:setup

$ bundle exec rails s
```

### Accéder à l'application

```
# /etc/hosts
127.0.0.1 guillamap.miamap.local
```

La partie application pour l'AMAP `La Guill'AMAP` est accessible à : http://guillamap.miamap.local:3000  

### Qualité logicielle 

```
# Tests unitaires et fonctionnels
$ bundle exec rspec
# Linter
$ bundle exec rubocop
```
