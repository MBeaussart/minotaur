# TP #2: Minotaur

![Minotaur](http://voyagesenduo.com/grece/crete/images/crete_image66.jpg)

Minotaurs are beasts between humans and bulls.
They often live within labyrinths, where they spend their time eating young ladies.
Sometimes, a hero comes and slays a Minotaur.
The goal of this homework is to help one of these heroes: Prof. Buchs, using logic programming.

As a technological warrior, Prof. Buchs goes into the labyrinth with his cell phone as a lighting source.
The cell phone consumes one battery unit in each room.
Alas, the battery may not be sufficient to reach the Minotaur or an exit.
In this case, Prof. Buchs is doomed to a never-ending death within the labyrinth.

A labyrinth is a set of rooms related with doors, that only open in one direction.
It is thus impossible to go back.
Our labyrinth does not contain cycles: it is impossible to come back later in a room.

1. Represent the doors of [this labyrinth](https://raw.githubusercontent.com/unige-semantics-2017/minotaur/master/labyrinth.pdf)
   with the `doors (from: Term, to: Term)` function.
   Its parameters are rooms.
2. Represent entrances and exits
   with the `entrance (location: Term)` and `exit (location: Term)` functions.
   Their parameter is a room.
3. Represent the Minotaur location
   with the `minotaur (location: Term)` function.
   Its parameter is a room.
4. Fill the `path (from: Term, to: Term, through: Term)` function.
   It makes a relation between the rooms `from` and `to` and a path `through` between them.
   This goal fails if there is no path between the two rooms,
   or if the `through` path does not start at `from` and end at `to`.
5. Fill the `battery (through: Term, level: Term)` function.
   It makes a relation between the battery of Prof. Buchs' cell phone and a path `through` the labyrinth.
   This goal fails if there is not enough battery.
6. Fill the `winning (through: Term, level: Term)` function.
   It makes a relation between a path through an entrance and an exit of the labyrinth,
   that visits the Minotaur, and where the battery `level` is sufficient.

## Test

You can run the tests using:
```shell
$ swift test     # for mac users
$ docker build . # for linux users
```

Do **not** modify the given tests.
You **should** add more tests in your own test functions.

## Grade

| Grade |
| ----- |
|       |
